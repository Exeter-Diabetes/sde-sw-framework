---
title: Chronic kidney disease
---

# Chronic kidney disease (CKD)

## Description

Identification and staging of chronic kidney disease (CKD) using routinely collected electronic health records (EHR), including information on kidney function, albuminuria, CKD diagnoses, dialysis and kidney transplantation.

We recommend following the CKD phenotyping algorithm developed by the BHF Data Science Centre's [Kidney Data Science Catalyst](https://bhfdatasciencecentre.org/areas/kidney-data-science-catalyst/).

&nbsp;

## CKD phenotyping algorithm

The Kidney Data Science Catalyst algorithm combines evidence from primary care records, linked secondary care records and demographic information to identify and stage CKD.

The algorithm incorporates:

- Primary care SNOMED CT codes for CKD diagnoses and kidney-related procedures.
- Secondary care ICD-10 diagnostic codes.
- Secondary care OPCS-4 procedure codes.
- Serum creatinine measurements used to derive estimated glomerular filtration rate (eGFR).
- Urine albumin-to-creatinine ratio (ACR) measurements.
- Evidence of chronicity from repeated measurements.
- Evidence of dialysis and kidney transplantation.

The algorithm derives eGFR using the CKD-EPI 2021 equation and incorporates CKD staging based on kidney function (G stage) and albuminuria (A stage).

The algorithm also includes rules for assigning CKD status where laboratory measurements or other information are incomplete.

&nbsp;

## Codelists and implementation resources

### Kidney Data Science Catalyst resources

- [CKD phenotyping algorithm repository](https://github.com/BHFDSC/hds_phenotypes_ckd)
- [Detailed algorithm documentation](https://github.com/BHFDSC/hds_phenotypes_ckd/blob/HEAD/docs/CKD_algorithm_markdown_updated.md)
- [Algorithm implementation code](https://github.com/BHFDSC/hds_phenotypes_ckd/tree/HEAD/hds_phenotypes_ckd/6.%20algorithm)
- [CKD, creatinine and ACR codelists](https://github.com/BHFDSC/hds_phenotypes_ckd/tree/HEAD/hds_phenotypes_ckd/1.%20codelists)

### HDR UK Phenotype Library

| Phenotype | Codelist |
|---|---|
| Chronic kidney disease | [PH4035](https://phenotypes.healthdatagateway.org/phenotypes/PH4035/version/9272/detail/) |
| Dialysis | [PH4036](https://phenotypes.healthdatagateway.org/phenotypes/PH4036/version/9238/detail/) |
| Kidney transplantation | [PH4037](https://phenotypes.healthdatagateway.org/phenotypes/PH4037/version/9239/detail/) |
| Congenital kidney disease | [PH4038](https://phenotypes.healthdatagateway.org/phenotypes/PH4038/version/9240/detail/) |

### Related DIA-Core resources

- [Serum creatinine and eGFR](../../investigations/eGFR/index.md)
- [Urine albumin-to-creatinine ratio (ACR)](../../investigations/ACR/index.md)

Additional information on approaches previously used to derive longitudinal CKD stages in CPRD is available from the [University of Exeter CPRD codelist repository](https://github.com/Exeter-Diabetes/CPRD-Codelists#ckd-chronic-kidney-disease-stage).

&nbsp;

## DIA-Core implementation

Apply the Kidney Data Science Catalyst CKD phenotyping algorithm to available primary care and linked secondary care data for individuals in the diabetes cohort.

The following information should be retained to support downstream research:

- CKD status and estimated date of diagnosis.
- CKD stage based on kidney function (G stage).
- Albuminuria stage (A stage).
- Recorded dialysis history.
- Recorded kidney transplantation history.
- Longitudinal serum creatinine and eGFR measurements.
- Longitudinal urine ACR measurements.
- Source of evidence used to identify and stage CKD.

Where possible, retain dates of changes in CKD stage and dates of kidney-related procedures to enable research into longitudinal CKD progression.

Where the upstream algorithm provides a single CKD status or stage, additional longitudinal processing may be required to derive changes in CKD stage over time.

&nbsp;

## General implementation rules

- Check that clinical event and measurement dates are consistent with patient dates of birth and death and data source coverage.
- Standardise serum creatinine and ACR measurement units.
- Apply the recommended rules for confirming chronicity and assigning CKD stage.
- Document the eGFR equation and algorithm version used.
- Document any differences between the recommended algorithm and local implementation, including differences in laboratory measurement availability.
- Where secondary care data are unavailable, document the limitations of CKD ascertainment using primary care data alone.

See the [standardised DIA-Core input data requirements](../../../projects/Core%20dataset/data_requirements.md) for further information on the data required to implement this phenotype.
