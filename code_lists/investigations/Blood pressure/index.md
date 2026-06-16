---
title: Blood pressure
---

## Description

Identifying and cleaning systolic and diastolic blood pressure values in EHR data. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Systolic blood pressure (SBP): remove values less than 40 and greater than 270 mmHg as these are implausible. Diastolic blood pressure (DBP): remove values less than 20 and greater than 200 mmHg as these are implausible.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values of recorded on the same day for a patient, we take the mean (SBP and DBP processed separately).

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
