/* =====================================================================
   STEP 7: DERIVE EARLIEST DIABETES DIAGNOSIS DATE PER PATIENT
   ---------------------------------------------------------------------
   Purpose
   -------
   Integrate diagnostic, biochemical, and pharmacological evidence to
   determine the earliest date of diabetes diagnosis for each patient.

   Evidence sources include:
   1. Earliest clean diabetes code (Step 2)
   2. Earliest HbA1c ≥48 mmol/mol (Step 5)
   3. Earliest glucose-lowering medication prescription (Step 6)

   Inputs
   ------
   - earliest_diabetes_code               (Step 2)
   - earliest_hba1c_per_patient           (Step 5)
   - earliest_insulin_per_patient         (Step 6)
   - earliest_non_insulin_per_patient     (Step 6)

   Processing Logic
   ----------------
   - For each patient, join all evidence types based on patient_id
   - Identify the earliest HbA1c and earliest medication dates
   - Determine overall earliest diabetes evidence date among:
        * earliest diabetes code
        * earliest HbA1c ≥48 mmol/mol
        * earliest glucose-lowering medication
   - Retain patient-level columns for each evidence type and the overall earliest date

   Output
   ------
   diabetes_diagnosis_dates:
   - patient_id
   - earliest_diabetes_code_date
   - earliest_hba1c_48_date
   - earliest_glucose_med_date
   - earliest_diabetes_evidence_date

===================================================================== */

/* ---------------------------------------------------------------------
   Earliest HbA1c >= 48 mmol/mol per patient
------------------------------------------------------------------------ */

WITH earliest_hba1c_per_patient AS (
    SELECT
        patient_id,
        MIN(hba1c_date) AS earliest_hba1c_48_date
    FROM hba1c_events_clean
    GROUP BY patient_id
),

/* ---------------------------------------------------------------------
   Combine insulin + non-insulin medication dates
------------------------------------------------------------------------ */

earliest_glucose_med_per_patient AS (
    SELECT
        patient_id,
        MIN(med_date) AS earliest_glucose_med_date
    FROM (
        SELECT
            patient_id,
            earliest_insulin_date AS med_date
        FROM earliest_insulin_per_patient

        UNION ALL

        SELECT
            patient_id,
            earliest_non_insulin_date AS med_date
        FROM earliest_non_insulin_per_patient
    ) m
    GROUP BY patient_id
),

/* ---------------------------------------------------------------------
   Combine all evidence types (anchored to clean diabetes code patients)
------------------------------------------------------------------------ */

diabetes_diagnosis_dates AS (
    SELECT
        dc.patient_id,

        dc.earliest_diabetes_code_date,
        hb.earliest_hba1c_48_date,
        med.earliest_glucose_med_date,

        /* Overall earliest evidence date */
        (
            SELECT MIN(d)
            FROM (VALUES
                (dc.earliest_diabetes_code_date),
                (hb.earliest_hba1c_48_date),
                (med.earliest_glucose_med_date)
            ) AS all_dates(d)
        ) AS earliest_diabetes_evidence_date

    FROM earliest_diabetes_code dc
    LEFT JOIN earliest_hba1c_per_patient hb
        ON dc.patient_id = hb.patient_id
    LEFT JOIN earliest_glucose_med_per_patient med
        ON dc.patient_id = med.patient_id
)

/* =====================================================================
   STEP 7 QA: VALIDATION OF EARLIEST DIAGNOSIS DATES
   ---------------------------------------------------------------------
   Purpose
   -------
   Assess completeness, temporal plausibility, and consistency of
   earliest diabetes diagnosis dates relative to constituent evidence types.

   Validation Outputs
   ------------------
   - Distribution of earliest overall diabetes evidence dates (min, P25, median, P75, max, mode)
   - Proportion of patients with HbA1c ≥48 mmol/mol
   - Proportion with HbA1c preceding earliest diabetes code
   - Proportion with any glucose-lowering medication
   - Proportion with medication preceding earliest diabetes code
   - Proportion with any HbA1c or medication evidence
   - Proportion with HbA1c or medication preceding earliest diabetes code
===================================================================== */

/* ---------------------------------------------------------------------
   QA: Distribution of earliest overall evidence date
------------------------------------------------------------------------ */

SELECT
    COUNT(*) AS n_patients,                                                  -- Number of patients with earliest evidence
    MIN(earliest_diabetes_evidence_date) AS min_date,                         -- Earliest evidence date
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY earliest_diabetes_evidence_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY earliest_diabetes_evidence_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY earliest_diabetes_evidence_date) AS p75_date,
    MAX(earliest_diabetes_evidence_date) AS max_date,                         -- Latest evidence date
    -- Mode: most frequently occurring earliest evidence date
    (SELECT TOP 1 earliest_diabetes_evidence_date
     FROM diabetes_diagnosis_dates
     GROUP BY earliest_diabetes_evidence_date
     ORDER BY COUNT(*) DESC) AS mode_date;

/* ---------------------------------------------------------------------
   QA: Validation metrics relative to earliest diabetes code
------------------------------------------------------------------------ */

SELECT
    COUNT(*) AS n_patients,                                                  -- Total patients in cohort

    -- HbA1c evidence
    AVG(CASE WHEN earliest_hba1c_48_date IS NOT NULL THEN 1.0 ELSE 0 END) AS pct_any_hba1c_48,
    AVG(CASE WHEN earliest_hba1c_48_date < earliest_diabetes_code_date THEN 1.0 ELSE 0 END) AS pct_hba1c_before_code,

    -- Medication evidence
    AVG(CASE WHEN earliest_glucose_med_date IS NOT NULL THEN 1.0 ELSE 0 END) AS pct_any_glucose_med,
    AVG(CASE WHEN earliest_glucose_med_date < earliest_diabetes_code_date THEN 1.0 ELSE 0 END) AS pct_med_before_code,

    -- Any alternative evidence (HbA1c or medication)
    AVG(CASE WHEN earliest_hba1c_48_date IS NOT NULL OR earliest_glucose_med_date IS NOT NULL THEN 1.0 ELSE 0 END) AS pct_any_hba1c_or_med,
    AVG(CASE WHEN earliest_hba1c_48_date < earliest_diabetes_code_date OR earliest_glucose_med_date < earliest_diabetes_code_date THEN 1.0 ELSE 0 END) AS pct_any_before_code
FROM diabetes_diagnosis_dates;