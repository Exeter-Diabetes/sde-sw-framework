/* =====================================================================
   STEP 4: CLEAN GLUCOSE-LOWERING MEDICATION PRESCRIPTIONS
   ---------------------------------------------------------------------
   Purpose
   -------
   Identify valid insulin and non-insulin glucose-lowering
   medication prescriptions for eligible patients.

   Inputs
   ------
   - primary_care_medications
   - eligible_patients (Step 1a)
   - reference.medications.insulin_dmd
   - reference.medications.insulin_names
   - reference.medications.non_insulin_dmd
   - reference.medications.non_insulin_names

   Processing Logic
   ----------------
   - Extract prescriptions linked to eligible patients
   - Identify insulin and non-insulin therapies using
     dm+d codes and medication name matching
   - Validate prescription dates:
        * Non-null
        * Within patient's observable lifetime
        * On or before milestone date

   Notes
   -----
   Multiple prescriptions on the same day are **retained separately**.
===================================================================== */

/* ---------------------------------------------------------------------
   STEP 4a: INSULIN PRESCRIPTIONS
--------------------------------------------------------------------- */

WITH insulin_medications_clean AS (
    SELECT
        ep.patient_id,
        m.prescription_date,
        m.dmd_code,
        m.drug_name,
        COALESCE(r.drug_substance, n.basal_bolus) AS insulin_type,
        'primary_care_medication' AS source_table
    FROM eligible_patients ep
    INNER JOIN primary_care_medications m
        ON ep.patient_id = m.sid_id
    LEFT JOIN reference.medications.insulin_dmd r
        ON m.dmd_code = r.dmd_code
    LEFT JOIN reference.medications.insulin_names n
        ON LOWER(m.drug_name) LIKE '%' || LOWER(n.name) || '%'
    WHERE m.prescription_date IS NOT NULL
      AND m.prescription_date >= DATEFROMPARTS(ep.yob,1,1)
      AND (ep.yod IS NULL OR m.prescription_date <= DATEFROMPARTS(ep.yod,12,31))
      AND m.prescription_date <= ep.milestone
),

/* ---------------------------------------------------------------------
   STEP 4b: NON-INSULIN GLUCOSE-LOWERING PRESCRIPTIONS
--------------------------------------------------------------------- */

non_insulin_medications_clean AS (
    SELECT
        ep.patient_id,
        m.prescription_date,
        m.dmd_code,
        m.drug_name,
        COALESCE(r.drug_class_1, r.drug_class_2, n.drug_class) AS med_class,
        'primary_care_medication' AS source_table
    FROM eligible_patients ep
    INNER JOIN primary_care_medications m
        ON ep.patient_id = m.sid_id
    LEFT JOIN reference.medications.non_insulin_dmd r
        ON m.dmd_code = r.dmd_code
    LEFT JOIN reference.medications.non_insulin_names n
        ON LOWER(m.drug_name) LIKE '%' || LOWER(n."Generic name") || '%'
    WHERE m.prescription_date IS NOT NULL
      AND m.prescription_date >= DATEFROMPARTS(ep.yob,1,1)
      AND (ep.yod IS NULL OR m.prescription_date <= DATEFROMPARTS(ep.yod,12,31))
      AND m.prescription_date <= ep.milestone
)

/* =====================================================================
   STEP 4 QA: MEDICATION PRESCRIPTION SUMMARY
   ---------------------------------------------------------------------
   Purpose
   -------
   Assess completeness and temporal plausibility of insulin and
   non-insulin glucose-lowering medication exposure prior to
   phenotype classification.

   Validation Outputs
   ------------------
   - Number of patients receiving prescriptions
   - Total prescription events
   - Distribution of prescription dates
===================================================================== */

/* -----------------------------
   QA for insulin
----------------------------- */

SELECT
    'Insulin' AS medication_type,
    COUNT(DISTINCT patient_id) AS n_patients,
    COUNT(*) AS n_events,
    MIN(prescription_date) AS min_date,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY prescription_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY prescription_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY prescription_date) AS p75_date,
    MAX(prescription_date) AS max_date,
    (SELECT TOP 1 prescription_date
     FROM insulin_medications_clean
     GROUP BY prescription_date
     ORDER BY COUNT(*) DESC) AS mode_date
FROM insulin_medications_clean;

/* -----------------------------
   QA for non-insulin glucose-lowering medications
----------------------------- */

SELECT
    'Non-Insulin' AS medication_type,
    COUNT(DISTINCT patient_id) AS n_patients,
    COUNT(*) AS n_events,
    MIN(prescription_date) AS min_date,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY prescription_date) AS p25_date,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY prescription_date) AS median_date,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY prescription_date) AS p75_date,
    MAX(prescription_date) AS max_date,
    (SELECT TOP 1 prescription_date
     FROM non_insulin_medications_clean
     GROUP BY prescription_date
     ORDER BY COUNT(*) DESC) AS mode_date
FROM non_insulin_medications_clean;
