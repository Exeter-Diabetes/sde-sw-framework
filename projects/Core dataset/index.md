# Diabetes Core Dataset

This page details the variables included in the Diabetes Core Dataset and the steps to derive these variables from GP data. For each core variable, we recommend that the dataset produced includes all available instances for each patient (i.e. a longitudinal structure) such as repeated BMI measurements or all recorded cardiovascular disease events, to maximise flexibility for downstream research use. An SQL implementation currently being developed by Kent, Medway and Sussex (KMS) SDE can be found [here](KMS%20implementation/README.md). The Diabetes Core Dataset is listed as a tool on the [HDR UK Health Data Research Gateway](https://healthdatagateway.org/en/tool/426).

&nbsp;

## Variables included in the Diabetes Core Dataset

This dataset was agreed by expert consensus with input from patients and the public (paper TBC). 

Patient identifiers required for data linkage and information describing the data source (such as start and end dates e.g. patient registration date in primary care) are considered structural requirements of the dataset and not explicitly listed below.

| Domain | No. | Data item |
|---------|-----|-----------|
| Demographics and social determinants of health | 1 | Date of birth |
| Demographics and social determinants of health | 2 | Sex |
| Demographics and social determinants of health | 3 | Ethnicity |
| Demographics and social determinants of health | 4 | Date of death |
| Diabetes features | 5 | Age/date of diabetes diagnosis |
| Diabetes features | 6 | Diabetes type (including remission) |
| Clinical measurements | 7 | BMI |
| Clinical measurements | 8 | Weight |
| Clinical measurements | 9 | Height |
| Clinical measurements | 10 | Blood pressure |
| Biomarkers | 11 | HbA1c |
| Biomarkers | 12 | Lipids: total cholesterol |
| Biomarkers | 13 | Lipids: HDL |
| Biomarkers | 14 | Lipids: triglycerides |
| Biomarkers | 15 | Liver function: ALT |
| Biomarkers | 16 | Kidney function: eGFR |
| Biomarkers | 17 | Kidney function: urine ACR |
| Diabetes complications | 18 | Retinopathy |
| Diabetes complications | 19 | Foot complications (ulcer, infection, loss of sensation/pulse) |
| Diabetes complications | 20 | Lower limb amputation (minor and major) |
| Diabetes complications | 21 | Cardiovascular disease: overall and by subtype (including hypertension and heart failure) |
| Diabetes complications | 22 | Chronic kidney disease stage plus transplant, dialysis |
| Diabetes complications | 23 | Diabetic ketoacidosis (DKA) / hyperosmolar hyperglycaemic state (HHS) |
| Lifestyle | 24 | Alcohol status |
| Lifestyle | 25 | Smoking status |
| Treatment of diabetes and associated conditions | 26 | Diabetes glucose-lowering medication |
| Treatment of diabetes and associated conditions | 27 | CGM prescription |
| Treatment of diabetes and associated conditions | 28 | Lipid lowering medication |
| Treatment of diabetes and associated conditions | 29 | Blood pressure lowering medication |
| Treatment of diabetes and associated conditions | 30 | Antiplatelet therapy |

&nbsp;

# Defining variables in GP data

Prerequisites:

* Date of birth should be available for all patients (at minimum, year of birth; month and year preferred). Patients without this information should be excluded. Where the exact date of birth is unavailable, we have developed an [algorithm for defining date of birth](../../code_lists/sociodemographics/date%20of%20birth/index.md); however, its use may be restricted by data source–specific governance or regulatory requirements.
* Sex/gender should be available for all patients (male/female/indeterminate or other)
* Additional data cleaning steps depend on data source: CPRD additional exclude those without valid registration date or aged >115 years, or from practices with anomalous mortality rates
* Date of death should preferentially come from ONS death data over primary or secondary care recorded date, if available.

&nbsp;

Additional considerations:

* Earliest codes for conditions such as diabetes may be stored in 'problem' or 'observation' table depending on data source.
* 'Last observable date': latest of data collection date, deregistration date from practice, and death date.

&nbsp;

| Step | Description | Output | Summary statistics for quality checking |
| ---- | ---- | ---- | ---- |
| 1 | Create a table of all [clean instances of all diabetes SNOMED codes](../../code_lists/conditions/diabetes/index.md) | 1 table with multiple rows per patient, with each clean instance of a diabetes SNOMED code including patient identifier, date of diabetes code observation, and type of diabetes code (type 1, type 2, NOS [not otherwise specified], Other) | Clean diabetes code dates: min, P25, P50, P75, max, mode. Number of unique patients with clean diabetes SNOMED code and % of patients in dataset |
| 2 | Find earliest clean diabetes code per patient | 1 table with 1 row per patient and date of earliest clean code observation | Distribution of earliest code dates: min, P25, P50, P75, max, mode. |
| 3 | Create a table of all [clean HbA1c measurements in mmol/mol](../../code_lists/investigations/HbA1c/index.md) | 1 table with multiple rows per patient, with each cleaned HbA1c measurement including patient identifier, date of result and value of result. Cleaning includes combining where there are multiple values on the same day so there should not be multiple rows with the same date and patient identifier. | Clean HbA1c values: min, P25, P50, P75, max, mode. Clean HbA1c dates: min, P25, P50, P75, max, mode. |
| 4 | Find earliest HbA1c>=48 mmol/mol per patient | 1 table with 1 row per patient and date of earliest clean HbA1c>=48 mmol/mol | Earliest code dates: min, P25, P50, P75, max, mode. Number of unique patients with HbA1c>=48 mmol/mol  (number of rows in table). |
| 5 | In patients with at least one elevated HbA1c (in table from step 4), identify those with two consecutive elevated HbA1c measurements. This will involve using the table produced in step 3 to check there are no intervening non-elevated HbA1cs | 1 table with 1 row per patient; only patient IDs required | N/A |
| 6 | Create tables of all [clean insulin and non-insulin glucose-lowering medication prescriptions](../../code_lists/medications/diabetes/index.md) | 2 tables (1 for insulin and 1 for non-insulin glucose-lowering medications) with multiple rows per patient, with each clean instance of a code including patient identifier, date of prescription, drug class and drug substance, and any information relating to quantity and dose available. There may be multiple rows with the same date and patient identifier if the patient has mutiple prescriptions for insulin or non-insulin glucose-lowering medications on the same day.| Clean insulin dates: min, P25, P50, P75, max, mode. Clean non-insulin glucose-lowering medication dates: min, P25, P50, P75, max, mode. Number of unique patients with clean insulin prescriptions (including those who also have clean non-insulin glucose-lowering medication prescriptions), number with clean non-insulin glucose-lowering medication prescriptions (including those who also have clean insulin prescriptions), and number with both. |
| 7 | Find earliest and latest insulin prescription dates, difference between these two dates, and time from latest script to present day (last observable date) for all patients with insulin prescriptions. | 1 table with 1 row per patient with earliets insulin date, latest insulin date, difference between latest and earliest in days, difference between last observable date and latest insulin script in days. | Latest-earliest date difference in days: min, P25, P50, P75, max, mode. Last observable date-latest date difference in days: min, P25, P50, P75, max, mode. |
| 8 | Identify diabetes cases: those with a diabetes code (table from step 2) OR two consecutive elevated HbA1cs (table from step 5) OR at least 6 months of insulin data (date difference >=183 days in table from step 7). | 1 row per patient with binary variables for diabetes code, two consecutive elevated HbA1cs, at least 6 months of insulin data. | Number of unique patients identified as cases (number of rows in table), number with diabetes code (including those meeting other criteria), number with two consecutive elevated HbA1cs ONLY, number with at least 6 months of insulin data ONLY, number with two consecutive elevated HbA1cs and at least 6 months of insulin data but no diabetes codes. |
| 9 | For diabetes cases, find diabetes diagnosis dates and ages: left join table from step 8 with table from step 2 (earliest diabetes code) and table from step 4 (earliest elevated HbA1c). Create a new diagnosis date variable which is the earliest diabetes code, unless the earliest elevated HbA1c is >1 year before the earliest diabetes codes, in which case use this. Use patient DOB to calculate age at diagnosis to one decimal point. Diagnosis date cannot be calculated for diabetes cases with at least 6 months of insulin data who have no diabetes codes or elevated HbA1cs. We also recommend removing diagnosis dates within -30 to +90 days (inclusive) of GP registration start date as they may represent pre-existing diagnoses (similar to [https://bmjopen.bmj.com/content/7/10/e017989](https://bmjopen.bmj.com/content/7/10/e017989) except we also excluded diagnoses up to 30 days before registration as our analysis in CPRD showed an excess of diagnoses in this period). | Diagnosis dates: min, P25, P50, P75, max, mode. Diagnosis ages: min, P25, P50, P75, max, mode. Number of unique patients for whom diagnosis date could not be ascertained. |
| 10 | For diabetes cases, calculate time from earliest script to diagnosis date for all patients with insulin prescriptions (diagnosis dates from step 9 should be used, and earliest insulin from step 7 can be used). If time to insulin from diagnosis is negative and more than a year prior to diagnosis, consider removing diagnosis date as it may be unreliable. | 1 row per patient with time to insulin from diagnosis in days. | N/A |
| 11 | Find counts of type 1 and type 2-specific diabetes codes per patient using clean table from step 1 | Table with 1 row per patient and counts of type 1-specific diabetes SNOMED codes and counts of type 2-specific diabetes SNOMED codes | N/A |
| 12 | For diabetes cases, follow the [DDSC algorithm](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/) to define diabetes type as 'diabetes other', 'type 1 diabetes', 'type 2 diabetes', 'diabetes NOS [not otherwise specified]' or 'diabetes unlikely'. All variables required are in tables produced by the above steps 1-11. See additional notes [here](../../code_lists/conditions/diabetes/index.md). Join to diabetes diagnosis dates and ages from step 9. | 1 table with 1 row per patient and diabetes types | For each diabetes type: number of patients, diagnosis age: min, P25, P50, P75, max, mode. |
| 13 | Use [cleaned ethnicity codes](../../code_lists/sociodemographics/ethncity/index.md) to define ethnicity | 1 table with 1 row per patient and ethnicity | % of all patients in each of 5-category and 11-category ethnicities and with missing ethnicity |
| 14 | For each of the following variables, create a table of all clean instances of the relevant SNOMED codes:<ul><li>[BMI](../../code_lists/investigations/BMI/index.md)</li><li>[Weight](../../code_lists/investigations/Weight/index.md)</li><li>[Height](../../code_lists/investigations/Height/index.md)</li><li>[Systolic blood pressure (SBP) and diastolic blood pressure (DBP)](../../code_lists/investigations/Weight/index.md)</li><li>[Total cholesterol](../../code_lists/investigations/Total%20Ccholesterol/index.md)</li><li>[HDL cholesterol](../../code_lists/investigations/HDL/index.md)</li><li>[Triglycerides](../../code_lists/investigations/Triglycerides/index.md)</li><li>[Alanine aminotransferase (ALT)](../../code_lists/investigations/ALT/index.md)</li><li>Creatinine (used to define [eGFR](../../code_lists/investigations/eGFR/index.md) )</li><li>[Urine albumin/creatinine ratio (ACR), urine albumin and urine creatinine](../../code_lists/investigations/ACR/index.md)</li><li>[Diabetes complications including retinopathy, foot complications, lower limb amputation, cardiovascular complications, chronic kidney disease, and diabetic ketoacidosis (DKA)/ hyperosmolar hyperglycaemic state (HHS)](../../code_lists/conditions/diabetes%20complications/index.md)</li><li>[Alcohol](../../code_lists/sociodemographics/alcohol%20status/index.md)</li><li>[Smoking](../../code_lists/sociodemographics/smoking%20status/index.md)</li><li>[CGM prescription](../../code_lists/medications/CGM/index.md)</li><li>[Lipid lowering medication prescription](../../code_lists/medications/lipid%20lowering%20medications/index.md)</li><li>[Blood pressure lowering medication prescription](../../code_lists/medications/blood%20pressure%20lowering%20medications/index.md)</li><li>[Antiplatelet therapy prescription](../../code_lists/medications/antiplatelet%20medications/index.md)</li></ul>| For each variable, table with multiple rows per patient including patient identifier, date, severity of code (retinopathy, foot complication, amputation only) and value of result (BMI, weight, height, SBP, DBP, total cholesterol, HDL, triglycerides, ALT, creatinine, urine albumin/creatinine/ACR only) | For all variables: clean dates: code dates: min, P25, P50, P75, max, mode. For measured values (BMI, weight, height, SBP, DBP, total cholesterol, HDL, triglycerides, ALT, creatinine, urine albumin/creatinine/ACR): clean values: min, P25, P50, P75, max, mode |

