---
title: Weight
---

## Description

Identifying and cleaning weight values in EHR data. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

## Rules

The plausibility thresholds below are intended for adult populations (aged 18 years and over). For children and adolescents, age-appropriate and, where relevant, sex-specific plausibility thresholds should be applied.

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise values to kg using recorded unit information where available.
2. Remove values less than 40 and greater than 350 kg as these are implausible for adults.
3. If multiple values are recorded on the same day for a patient, take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
