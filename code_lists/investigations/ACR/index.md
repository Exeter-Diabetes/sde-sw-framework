---
title: ACR (urine albumin-creatinine ratio)
---

## Description

Identifying and cleaning measured urine ACR (albumin-creatinine ratio) values in EHR data. Three codelists are provided: urine ACR, urine albumin and urine creatinine.

## Rules

* Values associated with ACR codes should be used preferentially, and separate albumin and creatinine values used to calculate ACR where these are not available.

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Remove values less than 0 and greater than 450 as these are implausible.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

## Origins

* The origins of the SNOMED codelists were the Pathology Bounded Code List (PBCL).

## Data

* [Urine albumin-creatinine ratio SNOMED](acr_snomed.csv)
* [Urine albumin SNOMED](albumin_urine_snomed.csv)
* [Urine creatinine SNOMED](creatinine_snomed.csv)
