---
title: BMI
---

## Description

Identifying and cleaning BMI values in EHR data. We recommend using the BMI marker codelist developed by the BHF HDR UK Diabetes Data Science Catalyst (DDSC) Defining Diabetes project.

## Codelists

- [DDSC BMI markers SNOMED CT codelist](https://github.com/BHFDSC/hds_phenotypes_diabetes/blob/main/hds_phenotypes_diabetes/1.%20codelists/bmi_markers.csv)

The codelist includes both BMI measurement concepts and categorical BMI findings. To derive continuous BMI, use recorded numerical measurement values; do not infer a numerical BMI from the category or range in a clinical code description alone.

## Rules

The plausibility thresholds below are intended for adult populations (aged 18 years and over). For children and adolescents, age-appropriate and, where relevant, sex-specific plausibility thresholds should be applied.

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise values to kg/m² using recorded unit information where available.
2. Remove values less than 15 and greater than 100 kg per square metre as these are implausible for adults.
3. If multiple values are recorded on the same day for a patient, take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We have found that calculating BMI from separate weight and height measurements recorded in EHR adds little over just using recorded BMI values.
