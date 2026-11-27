---
title: Derivation of core variables
---

# Stage 2: Derivation of the remaining DIA-Core variables

## Overview

Following [Stage 1: Diabetes cohort ascertainment and classification](diabetes_cohort.md), the second stage of implementing the Diabetes Core Dataset (DIA-Core) involves deriving the remaining core dataset variables for individuals with diabetes.

We recommend retaining all available instances of each variable, where applicable, to maximise flexibility for downstream research. For example, the dataset should retain all cleaned BMI measurements, medication prescriptions and cardiovascular disease events, rather than only the most recent record.

See the [standardised input data requirements](data_requirements.md) for further information on the input tables, variables and coding systems required.

&nbsp;

## 1. Demographics

| Variable | Codelists and implementation guidance |
|---|---|
| Date of birth | [Date of birth](../../code_lists/sociodemographics/date%20of%20birth/index.md) |
| Sex | Recorded sex from patient demographics |
| Ethnicity | [Ethnicity](../../code_lists/sociodemographics/ethnicity/index.md) |
| Date of death | Preferentially derived from national mortality registration data where available |

Output: one row per patient containing demographic information.

Quality assurance: distribution of age, sex and ethnicity, including missingness, and number of recorded deaths.

&nbsp;

## 2. Diabetes features

Date and age at diabetes diagnosis and diabetes type are derived as part of [Stage 1](diabetes_cohort.md).

Information on diabetes remission should also be retained, where available, following the [diabetes phenotype guidance](../../code_lists/conditions/diabetes/index.md).

&nbsp;

## 3. Clinical measurements

| Variable | Codelists and implementation guidance |
|---|---|
| BMI | [BMI](../../code_lists/investigations/BMI/index.md) |
| Weight | [Weight](../../code_lists/investigations/Weight/index.md) |
| Height | [Height](../../code_lists/investigations/Height/index.md) |
| Systolic and diastolic blood pressure | [Blood pressure](../../code_lists/investigations/Blood%20pressure/index.md) |

Output: longitudinal tables containing patient identifier, measurement date, cleaned measurement value and standardised unit.

Quality assurance: distributions of measurement values and dates, number and percentage of patients with measurements, and frequency of measurements per patient.

&nbsp;

## 4. Biomarkers

| Variable | Codelists and implementation guidance |
|---|---|
| HbA1c | [HbA1c](../../code_lists/investigations/HbA1c/index.md) |
| Total cholesterol | [Total cholesterol](../../code_lists/investigations/Total%20cholesterol/index.md) |
| HDL cholesterol | [HDL](../../code_lists/investigations/HDL/index.md) |
| Triglycerides | [Triglycerides](../../code_lists/investigations/Triglycerides/index.md) |
| Alanine aminotransferase (ALT) | [ALT](../../code_lists/investigations/ALT/index.md) |
| Estimated glomerular filtration rate (eGFR) | [eGFR and serum creatinine](../../code_lists/investigations/eGFR/index.md) |
| Urine albumin/creatinine ratio (ACR) | [ACR, urine albumin and urine creatinine](../../code_lists/investigations/ACR/index.md) |

Output: longitudinal tables containing patient identifier, measurement date, cleaned measurement value and standardised unit.

Quality assurance: distributions of measurement values and dates, number and percentage of patients with measurements, and frequency of measurements per patient.

Cleaned HbA1c measurements derived during Stage 1 can be reused.

&nbsp;

## 5. Diabetes complications

| Variable | Codelists and implementation guidance |
|---|---|
| Retinopathy | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |
| Foot complications | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |
| Lower limb amputation | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |
| Cardiovascular disease, including hypertension and heart failure | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |
| Chronic kidney disease, dialysis and kidney transplantation | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |
| Diabetic ketoacidosis (DKA) and hyperosmolar hyperglycaemic state (HHS) | [Diabetes complications](../../code_lists/conditions/diabetes%20complications/index.md) |

Where available, primary care records should be supplemented with linked secondary care and mortality data.

Output: longitudinal tables containing patient identifier, event date, complication type, subtype or severity (where applicable), and source of the clinical record.

Quality assurance: number and percentage of patients with each complication, distribution of event dates, frequency of recorded events per patient, and distribution of complication subtypes and severity.

&nbsp;

## 6. Lifestyle

| Variable | Codelists and implementation guidance |
|---|---|
| Alcohol status | [Alcohol status](../../code_lists/sociodemographics/alcohol%20status/index.md) |
| Smoking status | [Smoking status](../../code_lists/sociodemographics/smoking%20status/index.md) |

Output: longitudinal tables containing patient identifier, observation date and recorded lifestyle category.

Quality assurance: distribution of lifestyle categories, number and percentage of patients with recorded information, and frequency of records per patient.

&nbsp;

## 7. Medication and device prescriptions

| Variable | Codelists and implementation guidance |
|---|---|
| Diabetes glucose-lowering medications | [Diabetes medications](../../code_lists/medications/diabetes%20medications/index.md) |
| Continuous glucose monitoring devices | [CGM](../../code_lists/medications/CGM/index.md) |
| Lipid lowering medications | [Lipid lowering medications](../../code_lists/medications/lipid%20lowering%20medications/index.md) |
| Blood pressure lowering medications | [Blood pressure lowering medications](../../code_lists/medications/blood%20pressure%20lowering%20medications/index.md) |
| Antiplatelet therapy | [Antiplatelet medications](../../code_lists/medications/antiplatelet%20medications/index.md) |

Output: longitudinal tables containing patient identifier, prescription date, medication class, drug substance or device category, and available prescription quantity and dose information.

Quality assurance: distribution of prescription dates, number and percentage of patients prescribed each medication class, and frequency of prescriptions per patient.

Cleaned glucose-lowering medication prescription tables derived during Stage 1 can be reused.

&nbsp;

## Quality assurance

For continuous variables and dates, we recommend reporting the minimum, 25th percentile, median, 75th percentile, maximum and mode, where appropriate.

For categorical variables, we recommend reporting counts, percentages and missingness.

Data availability and completeness should be assessed for each core dataset variable, with any limitations in data coverage or adaptations to the recommended implementation documented.

&nbsp;

## Final dataset

The final Diabetes Core Dataset comprises:

- A patient-level diabetes cohort containing demographics and diabetes features.
- Longitudinal clinical measurement and biomarker tables.
- Longitudinal diabetes complication tables.
- Longitudinal lifestyle information.
- Longitudinal medication and device prescription tables.

All tables should be linkable using a consistent pseudonymous patient identifier.

The physical structure of the dataset may vary between SDEs, but variable definitions, coding systems and derivation rules should be consistent wherever possible.
