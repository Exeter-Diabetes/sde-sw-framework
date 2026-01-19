# Core diabetes dataset

This page details the steps to produce the tables which comprise the core diabetes dataset in GP data. These tables can then be combined to create different diabetes cohorts.

Valid in the below...


| Step | Description | Dataset-specific considerations | Output | Summary statistics for quality checking |
| ---- | ---- | ---- | ---- | ---- |
| 1 | Create a table of all instances of all diabetes SNOMED codes | Codes may be stored in 'problem' and/or 'observation' table depending on system | Table with multiple rows per patient, with each valid instance of a diabetes SNOMED code including patient identifier, date of diabetes code observation, and type of diabetes code (type 1, type 2, unspecified diabetes type) | Number of unique patients with diabetes SNOMED code |
| 2 | Find earliest diabetes code per patient | Earliest code may be stored in 'problem' or 'observation' table depending on system | Table with 1 row per patient and date of earliest code observation | Distribution of earliest code dates: min, P25, P50, P75, max |
| 3 | Create a table of all instances of measured HbA1c | | Table with multiple rows per patient, with each instance of a valid HbA1c SNOMED code including patient identifier, date of result, value of result, and units of value where possible | ?? |
| 4 | Create a table of all insulin and non-insulin glucose-lowering medication prescriptions | | Table with multiple rows per patient, with each instance of a valid dm+d code including patient identifier, date of prescription, drug class and drug substance, and any information relating to drug sustance, quantity and dose available | ?? |
| 5 | Find earliest HbA1c>=48 mmol/mol per patient | | Table with 1 row per patient and date of earliest HbA1c>=48 mmol/mol (NB: this relates to values after cleaning, which includes combining multiple values if on the same day | Distribution of earliest code dates: min, P25, P50, P75, max |
| 6 | Find earliest insulin and non-insulin glucose-lowering medication prescription per patient | | Table with 1 row per patient and date of earliest prescription | Distribution of earliest code dates: min, P25, P50, P75, max |
| 7 | Find diabetes diagnosis dates: earliest of diabetes code (step 2), HbA1c>=48 mmol/mol (step 5) and glucose-lowering medication prescription (step 6) | | Table with 1 row per patient and date of earliest diabetes code, HbA1c>=48 mmol/mol and glucose-lowering medication prescription, and overall earliest date of these | Of patients with a diabetes code: % with any HbA1c>=48mmol/mol, % with earliest HbA1c>=48mmol/mol earlier than earliest diabetes code, % with any glucose-lowering medication prescription, % with earliest glucose-lowering medication prescription earlier than earliest diabetes code, % with any HbA1c>=48mmol/mol or glucose-lowering medication prescription, % with earliest HbA1c>=48mmol/mol or earliest glucose-lowering medication prescription earlier than earliest diabetes code |



Find earliest HbA1c>=48 mmol/mol and earliest glucose-lowering medication prescription and test whether these occur earlier than earliest diabetes code | | 1. Table of all HbA1c results (patient identifier, date of result, value of result, units of value where possible).<br>2. Table of all non-insulin glucose-lowering medication prescriptions (patient identifier, date of prescription, and any information relating to drug sustance, quantity and dose).<br>3. Table of all insulin prescriptions (variables as per 2.) | |







## 1. Pull out all instances of diabetes codes

| 

* Create a table of all instances of any diabetes SNOMED code (link). Patient identifier, date of diabetes observation, and type of diabetes code (type 1, type 2, unspecified diabetes type) are required for later steps.

&nbsp;

## 2a. Define patient diabetes diagnosis dates as earliest valid diabetes code for each patient

* Definition of valid will depend on dataset, availability of patient DOB and death dates, and prior data cleaning. Codes before patient DOB, after patient death, after patient deregistration and after data collection should be removed where possible.

* In some GP datasets, 'backdated' diabetes codes from before patient registration are available (with an input/enter date within registration, but an earlier observation date).

&nbsp;

## 2b. Explore whether adding earliest HbA1c>=48 mmol/mol and earliest diabetes medication impacts diabetes diagnosis date

* A table of all instances of measured HbA1c (patient identifier, date of result, value of result, units of value where possible) and a table of all instances of non-insulin and insulin diabetes medication prescriptions (patient identifier, date of prescription, and any information relating to drug sustance, quantity and dose) are required for later steps.

* These need to be 'valid' as above for diabetes codes

* HbA1c values require additional cleaning steps:
  * HbA1c values can be recorded in mmol/mol or %, and need to be converted to mmol/mol. Where units are not available, we have assumed values <=20 are in %.
  * Implausibly high or low values need to be removed: we only include values >=20 and <=195 mmol/mol
  * Where there are multiple values meeting the above criteria on the same day, we take the mean

* Depending on whether historical prescriptions and biomarker results are available, patients may have an earliest high HbA1c or earliest prescription for diabetes medication before their earliest diabetes code - if so then this should be used as their diagnosis date. It is useful to assess how many patients are affected by this and by how many days to check data quality.

&nbsp;

## 3. Define patient diabetes type based on insulin use and counts of type-specific diabetes codes

* We use insulin use and the relative numbers of type 1 and type 2 diabetes codes to define whether a patient has type 1 or type 2 diabetes, as follows:
  * No insulin prescriptions: Type 2
  * With at least one insulin prescription:
    * At least one Type 1 and no Type 2 codes: Type 1
    * At least one Type 2 and no Type 1 codes: Type 2
    * Mix of Type 1 and Type 2 codes: if number of Type 1 medcodes >=2 x number of Type 2 medcodes, Type 1, otherwise Type 2
    * No Type 1 or Type 2 codes: leave as 'unspecified'

&nbsp;

## 4. Pull all instances of sociodemographic/lifestyle codes, clinical measurements, biomarkers, procedures and diabetes complications and medication prescriptions as defined in the core dataset specification

This includes (in addition to HbA1c and non-insulin/insulin diabetes medications as above):
* Ethnicity
* BMI
* Weight
* Height
* SBP
* DBP
* Total cholesterol
* HDL
* Triglycerides
* ALT
* eGFR
* Urine ACR
* Urine albumin
* Urine creatinine
* Retinopathy
* Foot ulcer, infection, loss of sensation/pulse
* Minor/major amputation
* Myocardial infarction
* Heart failure
* Stroke
* Angina
* Peripheral arterial disease
* Peripheral arterial revascularisation
* Transient ischaemic attack
* Hypertension
* Atrial fibrillation
* Ischaemic heart disease
* Coronary revascularisation
* Chronic kidney disease stage 5
* Diabetic ketoacidosis/hyperosmolar hyperglycaemic state
* Alcohol
* Smoking
* CGM
* Lipid lowering medication
* Blood-pressure lowering medication
* Anti-platelet therapy
