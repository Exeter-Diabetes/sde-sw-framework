/* =====================================================================
   STEP 6: DERIVE EARLIEST MEDICATION EVIDENCE OF DIABETES
   ---------------------------------------------------------------------
   Purpose
   -------
   Identify the earliest prescription dates for each patient for:
   1. Insulin medications
   2. Non-insulin glucose-lowering medications

   These records provide pharmacological evidence supporting
   diabetes diagnosis and treatment trajectories.

   Inputs
   ------
   - insulin_medications_clean   (Step 4)
   - non_insulin_medications_clean (Step 4)

   Processing Logic
   ----------------
   - For each patient, determine the earliest prescription date for:
        * Insulin therapies
        * Non-insulin glucose-lowering therapies
   - One row per patient is retained per medication type

   Output
   ------
   - earliest_insulin_per_patient
       * patient_id
       * earliest_insulin_date
   - earliest_non_insulin_per_patient
       * patient_id
       * earliest_non_insulin_date
===================================================================== */

/* -----------------------------
   Earliest insulin prescription
----------------------------- */
WITH earliest_insulin_per_patient AS (
    SELECT
        patient_id,
        MIN(prescription_date) AS earliest_insulin_date
    FROM insulin_medications_clean
    GROUP BY patient_id
),

/* -----------------------------
   Earliest non-insulin prescription
----------------------------- */
earliest_non_insulin_per_patient AS (
    SELECT
        patient_id,
        MIN(prescription_date) AS earliest_non_insulin_date
    FROM non_insulin_medications
    GROUP BY patient_id
)

/* =====================================================================
   STEP 6 QA: EARLIEST MEDICATION SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Validate completeness and temporal plausibility of earliest
   medication prescriptions prior to phenotype derivation.

   Validation Outputs
   ------------------
   - Number of patients with earliest insulin prescriptions
   - Number of patients with earliest non-insulin prescriptions
   - Distribution of earliest prescription dates for each medication type
===================================================================== */

/* ---------------------------------------------------------------------
   QA: Validation metrics for earliest insulin prescriptions
------------------------------------------------------------------------ */

SELECT
    COUNT(DISTINCT patient_id) AS n_patients,                         -- Number of patients with insulin prescriptions
    MIN(earliest_insulin_date) AS min_date,                            -- Earliest insulin prescription date
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY earliest_insulin_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY earliest_insulin_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY earliest_insulin_date) AS p75_date,
    MAX(earliest_insulin_date) AS max_date,                            -- Latest insulin prescription date
    -- Mode calculation: most frequently occurring earliest insulin date
    (SELECT TOP 1 earliest_insulin_date
     FROM earliest_insulin_per_patient
     GROUP BY earliest_insulin_date
     ORDER BY COUNT(*) DESC) AS mode_date;

/* ---------------------------------------------------------------------
   QA: Validation metrics for earliest non-insulin prescriptions
------------------------------------------------------------------------ */
SELECT
    COUNT(DISTINCT patient_id) AS n_patients,                         -- Number of patients with non-insulin prescriptions
    MIN(earliest_non_insulin_date) AS min_date,                        -- Earliest non-insulin prescription date
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY earliest_non_insulin_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY earliest_non_insulin_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY earliest_non_insulin_date) AS p75_date,
    MAX(earliest_non_insulin_date) AS max_date,                        -- Latest non-insulin prescription date
    -- Mode calculation: most frequently occurring earliest non-insulin date
    (SELECT TOP 1 earliest_non_insulin_date
     FROM earliest_non_insulin_per_patient
     GROUP BY earliest_non_insulin_date
     ORDER BY COUNT(*) DESC) AS mode_date;