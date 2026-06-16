---
title: HDL cholesterol (High-density lipoprotein)
---

## Description

Identifying and cleaning HDL cholesterol (High-density lipoprotein) values in EHR data.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Remove values less than 0.2 and greater than 10 mmol/L as these are implausible.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

## Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).

## Data

* [HDL SNOMED](hdl_snomed.csv)
