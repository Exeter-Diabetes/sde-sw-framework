---
title: Retinopathy
---

## Description

Identification of diabetic retinopathy using routinely collected electronic health records (EHR), including primary care clinical codes and linked secondary care diagnostic and procedure codes.

The University of Exeter retinopathy codelists were updated in 2025 to distinguish severe and non-severe retinopathy. Additional codelists are available for complications associated with severe retinopathy, including vitreous and pre-retinal haemorrhage and blindness and visual impairment.

&nbsp;

## Codelists

### Primary care (SNOMED CT)

| Phenotype | Codelist |
|---|---|
| Non-severe retinopathy | [Exeter non-severe retinopathy SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/non_severe_retinopathy_snomed.txt) |
| Severe retinopathy | [Exeter severe retinopathy SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/severe_retinopathy_snomed.txt) |
| Vitreous and pre-retinal haemorrhage | [Exeter vitreous haemorrhage SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/vithem_snomed.csv) |
| Blindness and visual impairment | [Exeter blindness and visual impairment SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/blindness_snomed.csv) |

Remove trailing hash (#) characters from SNOMED CT code identifiers before use and remove duplicate codes within each codelist.

### Secondary care (ICD-10)

| Phenotype | Codelist |
|---|---|
| Non-severe retinopathy | [Exeter non-severe retinopathy ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_non_severe_retinopathy.txt) |
| Severe retinopathy | [Exeter severe retinopathy ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_severe_retinopathy.txt) |
| Vitreous and pre-retinal haemorrhage | [Exeter vitreous haemorrhage ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_vitreous_and_pre_retinal_haemorrhage.txt) |
| Blindness and visual impairment | [Exeter blindness and visual impairment ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_blindness_and_visual_impairment.txt) |

### Secondary care (OPCS-4)

- [Exeter severe retinopathy OPCS-4 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/OPCS4/exeter_opcs4_severe_retinopathy.txt)

The OPCS-4 codelist includes retinal photocoagulation and intravitreal injection procedures.

&nbsp;

## Retinopathy severity

The existing Exeter codelists distinguish severe and non-severe retinopathy. The severe retinopathy codelists include proliferative retinopathy, more advanced forms of non-proliferative retinopathy and evidence of retinal treatment.

&nbsp;

## Composite severe retinopathy

An existing Exeter approach to defining composite severe retinopathy in CPRD Aurum and linked hospital data combines evidence of:

- Severe retinopathy, including retinal photocoagulation.
- Vitreous and pre-retinal haemorrhage.
- Blindness and visual impairment.

The date of composite severe retinopathy is defined as the earliest recorded date of any of these components.

A more specific alternative definition requires previous evidence of retinopathy for blindness or visual impairment to contribute to the composite outcome.

&nbsp;

## DIA-Core implementation

We recommend retaining longitudinal information on each of the following components separately:

| Component | Data sources |
|---|---|
| Non-severe retinopathy | Primary and secondary care diagnostic codes |
| Severe retinopathy | Primary and secondary care diagnostic and procedure codes |
| Vitreous and pre-retinal haemorrhage | Primary and secondary care diagnostic codes |
| Blindness and visual impairment | Primary and secondary care clinical codes |
| Retinal treatment procedures | Primary care procedure codes and secondary care OPCS-4 codes |

For each record, retain the patient identifier, event date, original clinical code, derived phenotype and data source.

Retaining individual components allows researchers to derive alternative definitions of retinopathy severity and composite outcomes without repeating the initial data extraction.

&nbsp;

## Rules

- Check that clinical event dates are consistent with data source coverage and patient dates of birth and death.
- Retain all recorded retinopathy diagnoses and relevant procedures.
- Retain separate dates for the earliest evidence of each phenotype.
- Distinguish recorded disease history from treatment procedures and newly recorded diagnoses where possible.
- Do not assume that severe and non-severe retinopathy are mutually exclusive.
- Document any additional criteria used to establish that diagnoses and procedures are attributable to diabetic retinopathy.
- Document the codelist versions and phenotype definitions used.

&nbsp;

## Quality assurance

- Number and percentage of patients with each retinopathy phenotype.
- Number of patients with evidence of both severe and non-severe retinopathy.
- Frequency of individual clinical codes.
- Distribution of event dates and age at first recorded event.
- Contribution of primary and secondary care data to each phenotype.
- Contribution of individual components to any composite severe retinopathy outcome.
