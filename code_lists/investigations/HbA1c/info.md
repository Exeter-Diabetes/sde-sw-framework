# Description

This is a list of codes for measured HbA1c values.

# Rules

* We check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We convert all values to mmol/mol; where unit codes are not available we assume values <=20 are in % and require conversion.

* We remove mmol/mol values less than 20 and greater than 195 mmol/mol as these are implausible.

* We apply additional cleaning rules based on unit codes where available.

* If multiple values recorded on the same day for a patient, we take the mean.

# Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).
