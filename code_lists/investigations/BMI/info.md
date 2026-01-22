# Description

This is a list of codes for measured BMI values.

## Rules

* We check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We remove values less than 15 and greater than 100 kg per square meter as these are implausible for adults.

* We apply additional cleaning rules based on unit codes where available.

* If multiple values recorded on the same day for a patient, we take the mean.

## Origins

* The origin of the SNOMED codelist was source codelists from Andy McGovern/RCGP and the BHF; reviewed by Andy McGovern in 2021.

## Data

* [BMI SNOMED](bmi_snomed.csv)