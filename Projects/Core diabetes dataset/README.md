# Core diabetes dataset

This page details the steps to produce the tables which comprise the core diabetes dataset. These tables can then be combined to create different diabetes cohorts.

## 1. Pull out all instances of diabetes codes
* Create a table of all instances of any diabetes SNOMED code (). Patient identifier, date of diabetes observation, and type of diabetes code (type 1, type 2, unspecified diabetes type) are required for later steps.

## 2a. Define patient diabetes diagnosis dates as earliest valid diabetes code for each patient
* Definition of valid will depend on dataset, availability of patient DOB and death dates, and prior data cleaning. Codes before patient DOB, after patient death, after patient deregistration and after data collection should be removed where possible.
* In some GP datasets, 'backdated' diabetes codes from before patient registration are available (with an input/enter date within registration, but an ealrier observation date).

## 2b. Explore whether adding earliest HbA1c>=48 mmol/mol and earliest diabetes medication impacts diabetes diagnosis date
* A table of all instances of measured HbA1c (patient identifier, date of result, value of result, units of value where possible) and a table of all instances of diabetes medication prescriptions (patient identifier, date of prescription, and any information relating to drug sustance, quantity and dose) are required for later steps.
* These need to be cleaned as above for diabetes codes
* HbA1c values require additional cleaning steps:
** HbA1c values can be recorded in mmol/mol or %, and need to be converted to mmol/mol. Where units are not available, we have assumed values <=20 are in %.
** Implausibly high or low values need to be removed: we only include values >=20 and <=195 mmol/mol
** Where there are multiple values meeting the above criteria on the same day, we take the mean
* Depending on whether historical prescriptions and biomarker results are available, patients may have an earliest high HbA1c or earliest prescription for diabetes medication before their earliest diabetes code - if so then this should be used as their diagnosis date. It is useful to assess how many patients are affected by this and by how many days to check data quality.

## 3. Define patient diabetes type based on insulin use counts of type-specific diabetes codes
* This step
*
* We use the relative numbers of type 1 and type 2 diabetes codes to define whether a patient has type 1 or type 2 diabetes, as follows

## 4. Pull all instances of lifestyle/sociodemographic codes, clinical measurements, biomarkers, diabetes complications and medication as defined in the core dataset specification






### Diabetes algorithm in pseudo-code and links to codelists



## 2. Core variables - list and link to codelists
Table

Final data dictionary / table structure of what you produce
One table per variable for conditions / biomarkers etc - would want all events



## Could also have link to KMS code once written

