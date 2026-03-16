/* =====================================================================
   STEP 1a: DEFINE ELIGIBLE STUDY POPULATION
   ---------------------------------------------------------------------
   Purpose
   -------
   Define the baseline patient population eligible for diabetes
   phenotype assessment using valid demographic information.

   Inputs
   ------
   primary_care_patient_demographics

   Processing Logic
   ----------------
   Patients are included where:
   - A valid patient identifier is present
   - Year of birth and sex are recorded
   - Recorded age lies within a plausible range (0–115 years)
   - The patient is alive at the demographic milestone date,
     where year of death is available

   The milestone date represents the latest confirmed demographic
   observation point and is used to bound subsequent clinical events.

   Output
   ------
   eligible_patients:
   One row per patient meeting demographic eligibility criteria.
===================================================================== */

WITH eligible_patients AS (
    SELECT DISTINCT
        sid_id        AS patient_id,
        yob           AS year_of_birth,
        yod           AS year_of_death,
        sex,
        age,
        milestone     -- Demographics snapshot date
    FROM primary_care_patient_demographics
    WHERE
        sid_id IS NOT NULL
        AND yob IS NOT NULL
        AND sex IS NOT NULL
        AND age BETWEEN 0 AND 115
        AND (yod IS NULL OR milestone <= DATEFROMPARTS(yod,12,31))
),

/* =====================================================================
   STEP 1b: IDENTIFY VALID PRIMARY CARE DIABETES DIAGNOSIS EVENTS
   ---------------------------------------------------------------------
   Purpose
   -------
   Identify primary care encounters containing validated diabetes
   SNOMED codes among eligible patients. These events represent
   candidate diagnostic evidence for diabetes.

   Inputs
   ------
   - eligible_patients (Step 1a)
   - primary_care_encounter
   - reference_snomed_diabetes

   Processing Logic
   ----------------
   - Eligible patients are linked to primary care encounter records
   - Diabetes SNOMED codes are identified using the reference list
   - Gestational, secondary, monogenic, and non-diabetes conditions
     are excluded via the reference table
   - Event dates must:
        * occur on or after patient birth year
        * occur before recorded year of death (if present)
        * occur on or before the demographic milestone date
   - QOF indicators and encounter metadata are retained for
     downstream phenotype refinement and quality assurance

   Output
   ------
   diabetes_events:
   One row per patient per validated diabetes diagnosis event.
===================================================================== */

diabetes_events AS (
    SELECT
        e.SID_id                                AS patient_id,
        COALESCE(e.snomed_code, e.snomed_code_calc) AS snomed_code,
        d.diabetes_type,                        -- T1, T2, or Unspecified
        d.qof,                                  -- 1 = QOF code, 0 = non-QOF
        e.snomed_desc,                          -- Optional description for QA
        e.encounter_date,                       -- Event date
        e.prtyp,                                -- Practitioner type
        e.clinician_seen,                       -- Clinician identifier
        e.location                              -- Location of encounter
    FROM primary_care_encounter e
    INNER JOIN eligible_patients p
        ON e.SID_id = p.patient_id
    INNER JOIN reference_snomed_diabetes d
        ON COALESCE(e.snomed_code, e.snomed_code_calc) = d.snomed_code
    WHERE
        -- Event date >= patient DOB (Jan 1 of yob as fallback)
        e.encounter_date >= DATEFROMPARTS(p.yob, 1, 1)
        -- Event date <= patient year of death, if known
        AND (p.yod IS NULL OR e.encounter_date <= DATEFROMPARTS(p.yod, 12, 31))
        -- Event date <= demographics milestone date
        AND e.encounter_date <= p.milestone
)

/* =====================================================================
   STEP 1 QA: DIABETES EVENT EXTRACTION SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Assess completeness and temporal plausibility of extracted
   diabetes diagnosis events prior to phenotype derivation.

   Validation Outputs
   ------------------
   - Number of patients with recorded diabetes events
   - Total number of diagnosis events
   - Distribution of event dates across the study period
===================================================================== */

SELECT
    COUNT(DISTINCT patient_id) AS n_unique_patients,   -- Number of patients with at least 1 diabetes code
    COUNT(*) AS n_total_events,                        -- Total number of diabetes events (rows)
    MIN(encounter_date) AS min_event_date,            -- Earliest diabetes code observation
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY encounter_date) AS p25_event_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY encounter_date) AS median_event_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY encounter_date) AS p75_event_date,
    MAX(encounter_date) AS max_event_date,            -- Latest diabetes code observation
    -- Mode calculation: find the most frequently occurring encounter_date
    (SELECT TOP 1 encounter_date
     FROM diabetes_events
     GROUP BY encounter_date
     ORDER BY COUNT(*) DESC) AS mode_event_date
FROM diabetes_events;
