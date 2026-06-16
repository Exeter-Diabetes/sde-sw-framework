---
title: BMI
---

## Description

identifying and cleaning BMI values in EHR data. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Remove values less than 15 and greater than 100 kg per square metre as these are implausible for adults.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We have found that calculating BMI from separate weight and height measurements recorded in EHR adds little over just using recorded BMI values.
