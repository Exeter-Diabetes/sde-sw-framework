# Description

This is a list of codes for a heart attack / myocardial infarction.

# Rules

* We check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* For all ICD10 codelists, we've included 3 and 4-digit ICD10 codes. The 3-digit codes are intended to be used as prefixes/wildcards e.g. I22 means any/all of I22.0, I22.1, I22.2 etc.

* We use earliest recorded code instance as date of diagnosis.

* We apply additional cleaning rules based on unit codes where available.

* If multiple values recorded on the same day for a patient, we take the mean.

# Origins

* The origin of the ICD10 codelist was Andy (McGovern) and it was reviewed by him in 2022.

* The origin of the SNOMED codelist was source codelists from Caliber and OpenSAFELY (i.e. we used codelists from other groups - we have copies of these which could be added to the repo?) and reviewed by Andy McG in 2021.