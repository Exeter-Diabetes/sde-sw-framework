/* =====================================================================
   STEP 5: DERIVE EARLIEST HBA1C EVIDENCE OF DIABETES
   ---------------------------------------------------------------------
   Purpose
   -------
   Determine the earliest recorded HbA1c measurement ≥48 mmol/mol for
   each patient, representing biochemical evidence of diabetes.
   This forms part of the diabetes diagnosis date algorithm.

   Inputs
   ------
   hba1c_events_dedup (Step 3)
   - Note: contains all valid HbA1c measurements (plausible values, valid dates)
     not restricted to the diagnostic threshold.

   Processing Logic
   ----------------
   - Filter to HbA1c measurements ≥48 mmol/mol (diagnostic threshold)
   - For each patient, identify the minimum HbA1c date meeting this threshold
   - One row per patient is retained with this earliest qualifying date

   Output
   ------
   earliest_hba1c_per_patient:
   One row per patient containing earliest HbA1c measurement
   consistent with diabetes diagnosis.
===================================================================== */

WITH earliest_hba1c_per_patient AS (
    SELECT
        patient_id,
        MIN(hba1c_date) AS earliest_hba1c_48_date
    FROM hba1c_events_clean
    WHERE hba1c_value >= 48       -- filter for diagnostic threshold
    GROUP BY patient_id
)

/* =====================================================================
   STEP 5 QA: EARLIEST HBA1C SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Assess completeness and temporal plausibility of earliest HbA1c
   measurements prior to incorporation into the phenotype algorithm.

   Validation Outputs
   ------------------
   - Number of patients with earliest HbA1c ≥48 mmol/mol
   - Distribution of earliest HbA1c dates (min, P25, median, P75, max, mode)
===================================================================== */

SELECT
    COUNT(DISTINCT patient_id) AS n_patients,                         -- Number of patients with HbA1c>=48
    MIN(earliest_hba1c_date) AS min_date,                             -- Earliest HbA1c across all patients
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY earliest_hba1c_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY earliest_hba1c_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY earliest_hba1c_date) AS p75_date,
    MAX(earliest_hba1c_date) AS max_date,                             -- Latest earliest HbA1c
    -- Mode calculation: most frequently occurring earliest HbA1c date
    (SELECT TOP 1 earliest_hba1c_date
     FROM earliest_hba1c_per_patient
     GROUP BY earliest_hba1c_date
     ORDER BY COUNT(*) DESC) AS mode_date
FROM earliest_hba1c_per_patient;