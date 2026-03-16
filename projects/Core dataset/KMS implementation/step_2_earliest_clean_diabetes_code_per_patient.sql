/* =====================================================================
   STEP 2: DERIVE EARLIEST DIABETES DIAGNOSIS DATE
   ---------------------------------------------------------------------
   Purpose
   -------
   Derive the earliest recorded evidence of diabetes diagnosis for
   each patient based on validated primary care diabetes events.

   Inputs
   ------
   diabetes_events (Step 1b)

   Processing Logic
   ----------------
   The earliest diagnosis date is defined as the minimum encounter
   date associated with a validated diabetes SNOMED code for each
   patient.

   Output
   ------
   earliest_diabetes_code:
   One row per patient containing the earliest recorded diabetes
   diagnosis date.
===================================================================== */

WITH earliest_diabetes_code AS (
    SELECT
        patient_id,
        MIN(encounter_date) AS earliest_code_date
    FROM diabetes_events
    GROUP BY patient_id
)

/* =====================================================================
   STEP 2 QA: EARLIEST DIAGNOSIS DATE SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Validate distribution and coverage of derived earliest diabetes
   diagnosis dates following patient-level aggregation.

   Validation Outputs
   ------------------
   - Number of patients with derived diagnosis dates
   - Temporal distribution of earliest diagnosis dates
===================================================================== */

SELECT
    COUNT(*) AS n_patients,                                     -- Number of patients with a diabetes code
    MIN(earliest_code_date) AS min_date,                        -- Earliest code across all patients
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY earliest_code_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY earliest_code_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY earliest_code_date) AS p75_date,
    MAX(earliest_code_date) AS max_date,                        -- Latest earliest code
    -- Mode calculation: most frequently occurring earliest code date
    (SELECT TOP 1 earliest_code_date
     FROM earliest_diabetes_code
     GROUP BY earliest_code_date
     ORDER BY COUNT(*) DESC) AS mode_date
FROM earliest_diabetes_code;
