---
title: Height
---

## Description

Identifying and cleaning height values in EHR data. We recommend using the SNOMED CT codelist developed by the University of Exeter.

## Codelists

- [Exeter height SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Biomarkers/SNOMED%20codelists/exeter_snomed_codelist_height_final.csv)

Extract the snomedcode field, remove trailing hash (#) characters from code identifiers and remove duplicate codes before use. The codelist includes measurement concepts and other clinical findings. Use associated numerical measurement values to derive continuous height; do not infer numerical values from clinical code descriptions alone.

## Rules

The plausibility thresholds below are intended for adult populations (aged 18 years and over). For children and adolescents, age-appropriate and, where relevant, sex-specific plausibility thresholds should be applied.

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise values to cm using recorded unit information where available.
2. Remove values less than 60 and greater than 225 cm as these are implausible for adults.
3. If multiple values are recorded on the same day for a patient, take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
