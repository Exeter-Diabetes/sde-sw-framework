---
title: Height
---

## Description

Identifying and cleaning height values in EHR data.. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Remove values less than 60 and greater than 225 cm as these are implausible for adults.
2. Apply additional cleaning rules based on unit codes where available.
3. If multiple values recorded on the same day for a patient, we take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
