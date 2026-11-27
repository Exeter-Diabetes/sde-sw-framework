---
title: Retinopathy
---

## Description

Identification of diabetic retinopathy using routinely collected electronic health records (EHR).

Retinopathy can be identified using primary care clinical codes and linked secondary care diagnostic and procedure codes.

&nbsp;

## Codelists

### Primary care

- [Exeter retinopathy SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_retinopathy_final.csv)

When using the Exeter SNOMED CT codelist, extract the snomedcode field, remove trailing hash (#) characters and remove duplicate codes.

### Secondary care

- [Exeter non-severe retinopathy ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_non_severe_retinopathy.txt)
- [Exeter severe retinopathy ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_severe_retinopathy.txt)
- [Exeter vitreous and pre-retinal haemorrhage ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_vitreous_and_pre_retinal_haemorrhage.txt)
- [Exeter severe retinopathy OPCS-4 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/OPCS4/exeter_opcs4_severe_retinopathy.txt)

&nbsp;

## Rules

- Check that clinical event dates are consistent with data source coverage and patient dates of birth and death.
- Retain all recorded retinopathy diagnoses and relevant procedures, including event dates and data sources.
- Distinguish severe and non-severe retinopathy where coding allows.
- Where severity cannot be reliably established, retain retinopathy status with severity classified as unknown.
- Distinguish recorded disease history from treatment procedures and newly recorded diagnoses where possible.
