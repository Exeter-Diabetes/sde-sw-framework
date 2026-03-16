/* =====================================================================
   STEP 8: DERIVE DIABETES CODE COUNTS FOR TYPE CLASSIFICATION
   ---------------------------------------------------------------------
   Purpose
   -------
   Calculate the number of clean diabetes diagnostic codes recorded
   per patient, stratified by diabetes type (Type 1 vs Type 2).  

   These counts provide evidence for subsequent diabetes type
   classification algorithms.

   Inputs
   ------
   - diabetes_events_clean (Step 1)
       * patient_id
       * snomed_code
   - reference_snomed_diabetes
       * snomed_code
       * diabetes_type ('type_1', 'type_2', or other)

   Processing Logic
   ----------------
   - For each patient, sum the number of T1-specific and T2-specific
     SNOMED codes
   - One row per patient is retained with counts for each diabetes type

   Output
   ------
   diabetes_code_counts_per_patient:
   - patient_id
   - n_type1_codes
   - n_type2_codes

===================================================================== */

/* ---------------------------------------------------------------------
   Count diabetes codes by type per patient
------------------------------------------------------------------------ */

WITH diabetes_code_counts_per_patient AS (
    SELECT
        d.patient_id,

        SUM(CASE
                WHEN r.diabetes_type = 'type_1' THEN 1
                ELSE 0
            END) AS n_type1_codes,

        SUM(CASE
                WHEN r.diabetes_type = 'type_2' THEN 1
                ELSE 0
            END) AS n_type2_codes

    FROM diabetes_events_clean d
    INNER JOIN reference_snomed_diabetes r
        ON d.snomed_code = r.snomed_code

    GROUP BY d.patient_id
)

/* =====================================================================
   STEP 8 QA: DIABETES CODE COUNT DISTRIBUTION
   ---------------------------------------------------------------------
   Purpose
   -------
   Validate completeness and variability of diabetes code counts
   prior to phenotype classification.

   Validation Outputs
   ------------------
   - Distribution of Type 1 code counts per patient
   - Distribution of Type 2 code counts per patient
===================================================================== */

/* ---------------------------------------------------------------------
   QA: Type 1 code count distribution
------------------------------------------------------------------------ */

SELECT
    COUNT(*) AS n_patients,                                              -- Total patients with Type 1 codes
    MIN(n_type1_codes) AS min_codes,                                      -- Minimum number of Type 1 codes per patient
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY n_type1_codes) AS p25_codes,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY n_type1_codes) AS median_codes,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY n_type1_codes) AS p75_codes,
    MAX(n_type1_codes) AS max_codes,                                      -- Maximum number of Type 1 codes per patient
    -- Mode: most frequently occurring Type 1 code count
    (SELECT TOP 1 n_type1_codes
     FROM diabetes_code_counts_per_patient
     GROUP BY n_type1_codes
     ORDER BY COUNT(*) DESC) AS mode_codes;

/* ---------------------------------------------------------------------
   QA: Type 2 code count distribution
------------------------------------------------------------------------ */

SELECT
    COUNT(*) AS n_patients,                                              -- Total patients with Type 2 codes
    MIN(n_type2_codes) AS min_codes,                                      -- Minimum number of Type 2 codes per patient
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY n_type2_codes) AS p25_codes,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY n_type2_codes) AS median_codes,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY n_type2_codes) AS p75_codes,
    MAX(n_type2_codes) AS max_codes,                                      -- Maximum number of Type 2 codes per patient
    -- Mode: most frequently occurring Type 2 code count
    (SELECT TOP 1 n_type2_codes
     FROM diabetes_code_counts_per_patient
     GROUP BY n_type2_codes
     ORDER BY COUNT(*) DESC) AS mode_codes;