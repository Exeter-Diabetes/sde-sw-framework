/* =====================================================================
   STEP 3: CLEAN HBA1C MEASUREMENTS
   ---------------------------------------------------------------------
   Purpose
   -------
   Generate a validated table of all HbA1c laboratory measurements
   for eligible patients, including all biologically plausible values.

   Inputs
   ------
   - primary_care_encounter
   - eligible_patients (Step 1a)
   - reference_snomed_hba1c

   Processing Logic
   ----------------
   - Identify HbA1c measurements using validated SNOMED codes
   - Extract numeric laboratory values and standardise
   - Apply plausibility and temporal checks:
        * HbA1c values between 20–195 mmol/mol
        * Valid event date within patient's observable lifetime
   - Aggregate multiple measurements on the same day for a patient

   Output
   ------
   hba1c_events_dedup:
   One row per patient per day containing all validated HbA1c measurements.
===================================================================== */

WITH hba1c_events_raw AS (
    SELECT
        e.sid_id                            AS patient_id,
        e.encounter_date                    AS hba1c_date,
        TRY_CAST(e.value1 AS DECIMAL(10,2)) AS hba1c_value,
        e.snomed_code_calc                  AS snomed_code,
        e.result_units,
        'primary_care_encounter'            AS source_table,
        p.year_of_birth,
        p.year_of_death
    FROM primary_care_encounter e
    INNER JOIN eligible_patients p
        ON e.sid_id = p.patient_id
    INNER JOIN reference_snomed_hba1c h
        ON e.snomed_code_calc = h.snomed_code
    WHERE e.encounter_date IS NOT NULL
      AND e.value1 IS NOT NULL
),

/* ---------------------------------------------------------------------
   STEP 3a: APPLY VALUE AND DATE VALIDATION
   ---------------------------------------------------------------------
   Purpose
   -------
   Apply clinical plausibility checks and temporal validation to
   HbA1c measurement records prior to aggregation.
--------------------------------------------------------------------- */

hba1c_events_clean AS (
    SELECT
        patient_id,
        hba1c_date,
        hba1c_value,
        snomed_code,
        result_units,
        source_table
    FROM hba1c_events_raw
    WHERE hba1c_value BETWEEN 20 AND 195       -- plausibility check
      AND hba1c_date >= DATEFROMPARTS(year_of_birth,1,1)
      AND (year_of_death IS NULL OR hba1c_date <= DATEFROMPARTS(year_of_death,12,31))
      AND hba1c_date <= milestone
),

/* ---------------------------------------------------------------------
   STEP 3b: CONSOLIDATE SAME-DAY HBA1C MEASUREMENTS
   ---------------------------------------------------------------------
   Purpose
   -------
   Aggregate multiple HbA1c results recorded for a patient on the
   same date into a single representative measurement.
--------------------------------------------------------------------- */

hba1c_events_dedup AS (
    SELECT
        patient_id,
        hba1c_date,
        AVG(hba1c_value) AS hba1c_value,       -- average if multiple values per day
        MAX(snomed_code) AS snomed_code,       -- retain one SNOMED code
        MAX(result_units) AS result_units,
        MAX(source_table) AS source_table
    FROM hba1c_events_clean
    GROUP BY patient_id, hba1c_date
)

/* =====================================================================
   STEP 3 QA: HBA1C MEASUREMENT SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Assess completeness, value distribution, and temporal
   plausibility of HbA1c measurements contributing biochemical
   evidence of diabetes.

   Validation Outputs
   ------------------
   - Number of patients with HbA1c ≥48 mmol/mol
   - Total number of qualifying HbA1c events
   - Distribution of HbA1c values
   - Distribution of measurement dates
===================================================================== */

SELECT
    COUNT(DISTINCT patient_id) AS n_patients,                     -- Number of patients with at least one measurement
    COUNT(*) AS n_events,                                         -- Total number of measurements
    MIN(hba1c_value) AS min_value,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY hba1c_value) AS p25_value,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY hba1c_value) AS median_value,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY hba1c_value) AS p75_value,
    MAX(hba1c_value) AS max_value,
    MIN(hba1c_date) AS min_date,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY hba1c_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY hba1c_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY hba1c_date) AS p75_date,
    MAX(hba1c_date) AS max_date,
    (SELECT TOP 1 hba1c_date
     FROM hba1c_events_dedup
     GROUP BY hba1c_date
     ORDER BY COUNT(*) DESC) AS mode_date
FROM hba1c_events_dedup;