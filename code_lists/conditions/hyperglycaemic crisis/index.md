---
title: Diabetic ketoacidosis and hyperosmolar hyperglycaemic state
---

## Description

Identification of diabetic ketoacidosis (DKA) and hyperosmolar hyperglycaemic state (HHS) using routinely collected electronic health records (EHR).

These acute complications can be identified using primary care clinical codes and linked secondary care diagnostic codes, with hospital admission data providing an important source of information on acute episodes.

&nbsp;

## Codelists

### Primary care (SNOMED CT)

- [Exeter hyperglycaemic crisis SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_hyperglycaemic_crisis_final.csv)

The codelist includes codes for DKA, HHS and other or unspecified hyperglycaemic crises.

Remove trailing hash (#) characters from SNOMED CT code identifiers before use and remove duplicate codes.

DKA and HHS can be distinguished using the individual clinical codes. Codes that do not specifically identify either DKA or HHS should be retained separately rather than assigned to either category.

### Secondary care (ICD-10)

- [Exeter DKA ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_dka.txt)

The codelist includes diabetes with ketoacidosis codes across different diabetes types.

A separate ICD-10 codelist for HHS is not currently available in the Exeter codelist repository. Diabetes with coma codes should not automatically be interpreted as HHS, as these may also capture other acute metabolic complications.

&nbsp;

## DIA-Core implementation

We recommend retaining longitudinal information on DKA and HHS separately where coding allows.

| Component | Data sources |
|---|---|
| Diabetic ketoacidosis (DKA) | Primary care SNOMED CT and secondary care ICD-10 codes |
| Hyperosmolar hyperglycaemic state (HHS) | Primary care SNOMED CT codes, supplemented by secondary care information where available |
| Other or unspecified hyperglycaemic crisis | Primary and secondary care clinical codes where appropriate |
| Hospitalisation with DKA or HHS | Secondary care admission and diagnostic records |

For each record, retain the patient identifier, event date, original clinical code, derived phenotype and data source.

For hospital admissions, retain admission and discharge dates, hospital spell identifiers where available, and diagnostic code position. This allows hospitalisations primarily due to DKA or HHS to be distinguished from admissions where these conditions are recorded as secondary diagnoses.

&nbsp;

## Rules

- Check that clinical event dates are consistent with data source coverage and patient dates of birth and death.
- Retain all recorded DKA and HHS clinical codes.
- Distinguish DKA and HHS where coding allows.
- Retain codes with uncertain or unspecified subtype separately.
- Distinguish primary care records of previous events from newly occurring acute episodes where possible.
- Distinguish primary and secondary hospital diagnoses.
- Avoid counting multiple diagnostic records within the same continuous hospital stay as separate acute episodes.
- Document the codelist versions and phenotype definitions used.

&nbsp;

## Quality assurance

- Number and percentage of patients with recorded DKA and HHS.
- Number of hospitalisations with DKA and HHS.
- Frequency of individual clinical codes.
- Distribution of event dates.
- Distribution of events by diabetes type.
- Contribution of primary and secondary care data to each phenotype.
- Distribution of primary and secondary hospital diagnostic positions.
