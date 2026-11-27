---
title: Blood pressure
---

## Description

Identifying and cleaning systolic and diastolic blood pressure values in EHR data. We recommend using the SNOMED CT codelists developed by the University of Exeter.

## Codelists

- [Exeter systolic blood pressure SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Biomarkers/SNOMED%20codelists/exeter_snomed_codelist_sbp_final.csv)
- [Exeter diastolic blood pressure SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Biomarkers/SNOMED%20codelists/exeter_snomed_codelist_dbp_final.csv)

Extract the snomedcode field, remove trailing hash (#) characters from code identifiers and remove duplicate codes before use. The codelists include measurement concepts and other clinical findings. Use associated numerical measurement values to derive continuous blood pressure; do not infer numerical values from clinical code descriptions alone. Retain measurement context (e.g. home, ambulatory or clinic readings) where available.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise values to mmHg using recorded unit information where available.
2. Systolic blood pressure (SBP): remove values less than 40 and greater than 270 mmHg as these are implausible. Diastolic blood pressure (DBP): remove values less than 20 and greater than 200 mmHg as these are implausible.
3. If multiple values are recorded on the same day for a patient, take the mean (SBP and DBP processed separately).

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
