# Core diabetes dataset

This page details the steps to produce the tables which comprise the core diabetes dataset in GP data. These tables can then be combined to create different diabetes cohorts.

Valid in the below...

Earliest code may be stored in 'problem' or 'observation' table depending on system 

Add sex to prerequisites

| Step | Description | Output | Summary statistics for quality checking |
| ---- | ---- | ---- | ---- |
| 1 | Create a table of all instances of all diabetes SNOMED codes | Table with multiple rows per patient, with each valid instance of a diabetes SNOMED code including patient identifier, date of diabetes code observation, and type of diabetes code (type 1, type 2, unspecified diabetes type) | Number of unique patients with diabetes SNOMED code |
| 2 | Find earliest diabetes code per patient | | Table with 1 row per patient and date of earliest code observation | Distribution of earliest code dates: min, P25, P50, P75, max |
| 3 | Create a table of all instances of measured HbA1c | Table with multiple rows per patient, with each instance of a valid HbA1c SNOMED code including patient identifier, date of result, value of result, and units of value where possible | ?? |
| 4 | Create a table of all insulin and non-insulin glucose-lowering medication prescriptions | Table with multiple rows per patient, with each instance of a valid dm+d code including patient identifier, date of prescription, drug class and drug substance, and any information relating to drug sustance, quantity and dose available | ?? |
| 5 | Find earliest HbA1c>=48 mmol/mol per patient | Table with 1 row per patient and date of earliest HbA1c>=48 mmol/mol (NB: this relates to values after cleaning, which includes combining multiple values if on the same day | Distribution of earliest code dates: min, P25, P50, P75, max |
| 6 | Find earliest insulin and non-insulin glucose-lowering medication prescription per patient | Table with 1 row per patient and date of earliest prescription | Distribution of earliest code dates: min, P25, P50, P75, max |
| 7 | Find diabetes diagnosis dates: earliest of diabetes code (step 2), HbA1c>=48 mmol/mol (step 5) and glucose-lowering medication prescription (step 6) | Table with 1 row per patient and date of earliest diabetes code, HbA1c>=48 mmol/mol and glucose-lowering medication prescription, and overall earliest date of these | Of patients with a diabetes code: % with any HbA1c>=48mmol/mol, % with earliest HbA1c>=48mmol/mol earlier than earliest diabetes code, % with any glucose-lowering medication prescription, % with earliest glucose-lowering medication prescription earlier than earliest diabetes code, % with any HbA1c>=48mmol/mol or glucose-lowering medication prescription, % with earliest HbA1c>=48mmol/mol or earliest glucose-lowering medication prescription earlier than earliest diabetes code |
| 8 | Find counts of type 1 and type 2-specific diabetes codes per patient | Table with 1 row per patient and counts of type 1-specific diabetes SNOMED codes (use raw data, not cleaned) and counts of type 2-specific diabetes SNOMED codes | ?? |
| 9 | Determine patient diabetes type using insulin use (step 4) and type 1 and type 2 code counts (step 8) as per our algorithm | Table with 1 row per patient and assigned diabetes type: 'type 1', 'type 2' or 'unclassified' | Of those with a diabetes code: % type 1, % type 2, % unclassified |
| 10 | For each of the following variables, create a table of all instances of the relevant SNOMED codes: 
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
* Anti-platelet therapy | | |
