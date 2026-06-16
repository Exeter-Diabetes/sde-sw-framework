---
title: eGFR (estimated glomerular filtration rate)
---

## Description

Defining and cleaning eGFR (estimated glomerular filtration rate) values in EHR data.

## Rules

* We recommend using cleaned serum creatinine values, age when value was measured and sex to calculate eGFR as per the [CKD-EPI Creatinine Equation 2021](https://www.kidney.org/professionals/kdoqi/gfr_calculator/formula) (ethnicity is not used in this equation). Using recorded eGFR values can lead to discrepancies where different equations have been used.

* Cleaning serum creatinine values (to note: steps 1-3 below should be carried out in this order to produce a standardised end result):

1. Remove values less than 20 and greater than 2500 μmol/L as these are implausible.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* eGFR values can be used to infer CKD stage (see [our previous work in CPRD](https://github.com/Exeter-Diabetes/CPRD-Codelists#ckd-chronic-kidney-disease-stage))

## Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).

## Data

* [Creatinine SNOMED](creatinine_blood_snomed.csv)
