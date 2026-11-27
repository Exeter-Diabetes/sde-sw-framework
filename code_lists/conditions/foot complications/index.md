---
title: Foot complications and lower limb amputation
---

## Description

Identification of diabetes-related foot complications using routinely collected electronic health records (EHR), including primary care clinical codes and linked secondary care diagnostic and procedure codes.

The Diabetes Core Dataset includes:

- Foot ulceration.
- Foot infection.
- Loss of sensation.
- Loss of foot pulses.
- Lower limb amputation (minor and major).

&nbsp;

## Foot ulceration, infection and ischaemia

The University of Exeter has developed a combined codelist for foot ulceration, infection and ischaemia.

### Primary care

- [Exeter foot ulcer, infection and ischaemia CPRD medcode codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/exeter_medcodelist_foot_ulcer_infection_ischaemia.txt)

A corresponding SNOMED CT codelist has been developed and is pending inclusion in the public codelist repository.

### Secondary care

- [Exeter foot ulcer, infection and ischaemia ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_foot_ulcer_infection_ischaemia.txt)

The current ICD-10 codelist identifies lower limb ulceration.

&nbsp;

## Foot screening and risk assessment

Information on foot complications and risk can also be obtained from clinical codes used in the NHS Quality and Outcomes Framework (QOF).

Historical QOF foot assessment codes (2004–2010) capture individual examination findings, including:

- Presence or absence of foot pulses.
- Normal or abnormal vibration sense.
- Normal or abnormal 10g monofilament sensation.

From 2011 onwards, QOF codes also capture overall foot risk classifications:

- Low risk.
- Moderate risk.
- High risk.
- Ulcerated foot.

The University of Exeter, working with collaborators at the University of Bristol, has incorporated these codes into a CPRD foot screening codelist.

- [Foot screening CPRD medcode codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/exeter_medcodelist_foot_screening.txt)

SNOMED CT equivalents and further implementation guidance for combining historical examination findings are pending.

### Implementation

- Abnormal vibration sense and abnormal monofilament sensation provide evidence of loss of sensation.
- Absent foot pulses provide evidence of loss of pulse.
- Ulcerated foot assessment codes provide additional evidence of foot ulceration.
- Moderate and high risk classifications may reflect sensory loss, impaired circulation or both, and should not be used in isolation to infer loss of sensation or absent pulses.
- Retain overall foot risk classifications as supplementary information where available.
- Retain laterality (left or right foot) where recorded.

&nbsp;

## Charcot foot

Charcot foot can be identified as an additional diabetes-related foot complication using the following codelists:

- [Exeter Charcot foot SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/charcot_foot_snomed.csv)
- [Exeter Charcot foot ICD-10 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/ICD10/exeter_icd10_charcot_foot.txt)

&nbsp;

## Lower limb amputation

Lower limb amputations should be identified primarily using secondary care procedure records, supplemented by primary care records where available.

### Primary care

- [Exeter lower limb amputation CPRD medcode codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/exeter_medcodelist_lower_limb_amputation.txt)

### Secondary care

- [Exeter lower limb amputation OPCS-4 codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/OPCS4/exeter_opcs4_lower_limb_amputation.txt)

The codelist includes the following OPCS-4 code groups:

| Code | Description |
|---|---|
| X09 | Amputation of leg |
| X10 | Amputation of foot |
| X11 | Amputation of toe |

Major and minor amputations should be distinguished using procedure-level information. Further guidance on classification and primary care SNOMED CT codelists is pending.

&nbsp;

## DIA-Core implementation

We recommend retaining longitudinal information on each of the following components separately, where available:

| Component | Data sources |
|---|---|
| Foot ulceration | Primary and secondary care clinical codes |
| Foot infection | Primary and secondary care clinical codes |
| Loss of sensation | Primary care foot examination codes |
| Absent foot pulses | Primary care foot examination codes |
| Lower limb amputation | Primary care clinical codes and secondary care OPCS-4 procedure codes |

Supplementary information may include foot ischaemia, foot risk classification, normal examination findings and Charcot foot.

For each record, retain the patient identifier, event date, original clinical code, derived phenotype, data source and laterality where available.

Where a codelist combines several complications, retain the original clinical code to support subsequent refinement of the phenotype.

&nbsp;

## Rules

- Check that clinical event dates are consistent with data source coverage and patient dates of birth and death.
- Retain all recorded foot complications, examination findings and amputation procedures.
- Distinguish normal and abnormal examination findings.
- Distinguish foot risk assessments from established foot complications.
- Distinguish recorded disease or amputation history from newly recorded events and procedures where possible.
- Distinguish major and minor amputations where coding allows.
- Remove trailing hash (#) characters from SNOMED CT code identifiers before use and remove duplicate codes within each codelist.
- Document the codelist versions and phenotype definitions used.

&nbsp;

## Quality assurance

- Number and percentage of patients with each foot complication.
- Number and percentage of patients with recorded foot examination findings.
- Distribution of normal and abnormal examination findings.
- Distribution of foot risk classifications where available.
- Number of patients with major and minor amputations.
- Frequency of individual clinical codes.
- Distribution of event dates.
- Contribution of primary and secondary care data to each phenotype.
