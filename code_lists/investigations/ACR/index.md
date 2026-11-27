---
title: ACR (urine albumin-creatinine ratio)
---

## Description

Identifying and cleaning measured urine ACR (albumin-creatinine ratio) values in EHR data. Three codelists are provided: urine ACR, urine albumin and urine creatinine.

## Rules

* Values associated with ACR codes should be used preferentially, and separate albumin and creatinine values used to calculate ACR where these are not available.

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise measured ACR values to mg/mmol using recorded unit information where available. Where ACR is calculated from separate urine albumin and creatinine measurements, ensure that the component measurements are expressed in compatible units.
2. Remove ACR values less than 0 and greater than 450 mg/mmol as these are considered implausible.
3. If multiple ACR values are recorded on the same day for a patient, take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

## Origins

* The origins of the SNOMED codelists were the Pathology Bounded Code List (PBCL).

## Data

* [Urine albumin-creatinine ratio SNOMED](acr_snomed.csv)
* [Urine albumin SNOMED](albumin_urine_snomed.csv)
* [Urine creatinine SNOMED](creatinine_urine_snomed.csv)
