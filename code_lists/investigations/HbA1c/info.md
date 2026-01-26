# Description

This is a list of codes for measured HbA1c values.

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* Convert all values to mmol/mol; where unit codes are not available we assume values <=20 are in % and require conversion.

* Remove mmol/mol values less than 20 and greater than 195 mmol/mol as these are implausible.

* Apply additional cleaning rules based on unit codes where available.

* If multiple values recorded on the same day for a patient, we take the mean.

* In patients with diabetes, the earliest HbA1c>=48 mmol/mol is used in the algorithm to define diagnosis date - see conditions/diabetes.

## Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).

## Data

* [HbA1c SNOMED](hba1c_snomed.csv)
