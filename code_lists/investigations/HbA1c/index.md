---
title: HbA1c
---

## Description

Identifying and cleaning HbA1c values iN EHR data.

## Rules

To note: steps 1-4 below should be carried out in this order to produce a standardised end reult:

1. Convert all values to mmol/mol; where unit codes are not available we assume values <=20 are in % and require conversion.
2. Remove values less than 20 or greater than 195 mmol/mol as these are implausible.
3. Apply additional cleaning rules based on unit codes where available.
4. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* In patients with diabetes, elevated HbA1c values (>=48 mmol/mol; based on clean values aggregated by patient identifier and date) are used in the algorithm to define diagnosis date - see conditions/diabetes.

## Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).

## Data

* [HbA1c SNOMED](hba1c_snomed.csv)
