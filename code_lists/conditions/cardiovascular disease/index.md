---
title: Cardiovascular disease
---

# Cardiovascular disease

## Description

Identification of cardiovascular disease in routinely collected electronic health records (EHR), including ischaemic heart disease, myocardial infarction, stroke, transient ischaemic attack, heart failure, hypertension and peripheral arterial disease.

We recommend deriving individual cardiovascular disease phenotypes separately to enable investigation of specific cardiovascular outcomes as well as composite outcomes.

For the ascertainment of acute cardiovascular events, we recommend using the phenotyping algorithms developed by the BHF Data Science Centre's [SCORE-CVD project](https://zenodo.org/records/8171481) (Standardising Clinical Outcome measures in Routinely collected Electronic healthcare systems data). These algorithms were developed through expert consensus to standardise cardiovascular outcome ascertainment using routinely collected health data.

Primary care diagnostic codelists should also be used to capture recorded cardiovascular disease history, including events that predate the availability of linked hospital data.

&nbsp;

## Myocardial infarction (MI)

### Acute MI events

We recommend using the SCORE-CVD myocardial infarction phenotyping algorithm to identify first and recurrent MI events using Hospital Episode Statistics Admitted Patient Care (HES APC) and Office for National Statistics (ONS) mortality data.

The algorithm uses ICD-10 codes I21 and I22, incorporating information on continuous inpatient spells, diagnosis position and timing of events to identify individual MI events and avoid double counting across data sources.

### Codelists and implementation resources

- [SCORE-CVD MI phenotyping algorithm repository](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi)
- [R implementation and documentation](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi/tree/HEAD/R_implementation_of%20MI_algorithm)
- [Databricks implementation](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi/tree/HEAD/Databricks_implementation_of_MI_algorithm)
- [Combined MI codelist](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi/blob/HEAD/Databricks_implementation_of_MI_algorithm/codelist/MI_algorithm_combined_codelist.csv)
- [Required input variables](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi/blob/HEAD/R_implementation_of%20MI_algorithm/docs/required_columns.csv)

The R implementation also includes simulated data and automated tests to support implementation in new data environments.

### Recorded history of MI

Primary care diagnostic codes can provide additional information on recorded MI history.

- [Exeter MI SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_myocardialinfarction_final.csv)

### DIA-Core implementation

Apply the SCORE-CVD MI algorithm to linked hospital and mortality records for individuals in the diabetes cohort, where these data are available.

Retain all identified MI events, including patient identifier, event date, event sequence (first or recurrent event) and source of ascertainment, where available.

Information on MI history derived from primary care diagnostic codes should be retained but distinguished from acute events identified using the SCORE-CVD algorithm.

&nbsp;

## Stroke

### Acute stroke events

We recommend using the SCORE-CVD stroke phenotyping algorithm to identify first and recurrent stroke events using linked HES APC and ONS mortality data.

The algorithm distinguishes the following stroke subtypes:

| Stroke subtype | Default ICD-10 codes |
|---|---|
| Ischaemic stroke | I63 |
| Haemorrhagic stroke | I60, I61 |
| Unknown stroke subtype | I64 |

The algorithm incorporates information on continuous inpatient spells, diagnosis position, timing of events and mortality records. Configurable parameters allow adaptation to different research requirements.

### Codelists and implementation resources

- [SCORE-CVD stroke phenotyping algorithm repository](https://github.com/BHFDSC/hds_phenotyping_score_cvd_stroke)
- [R implementation and documentation](https://github.com/BHFDSC/hds_phenotyping_score_cvd_stroke/tree/HEAD/R_implementation_of_stroke_algorithm)
- [Databricks implementation](https://github.com/BHFDSC/hds_phenotyping_score_cvd_stroke/tree/HEAD/Databricks_implementation_of_stroke_algorithm)
- [Combined stroke codelist](https://github.com/BHFDSC/hds_phenotyping_score_cvd_stroke/blob/HEAD/Databricks_implementation_of_stroke_algorithm/codelist/combined_codelist.csv)
- [Required input variables](https://github.com/BHFDSC/hds_phenotyping_score_cvd_stroke/blob/HEAD/R_implementation_of_stroke_algorithm/docs/required_columns.csv)

Simulated data and validation scripts are also provided within the R implementation.

### Recorded history of stroke

Primary care diagnostic codes can provide additional information on recorded stroke history.

- [Exeter stroke SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_stroke_final.csv)

### DIA-Core implementation

Apply the SCORE-CVD stroke algorithm to linked hospital and mortality records for individuals in the diabetes cohort, where these data are available.

Retain all identified stroke events, including patient identifier, event date, stroke subtype, event sequence (first or recurrent event), fatal stroke status and source of ascertainment.

Algorithm parameters should be selected according to the intended research application and documented.

Information on stroke history derived from primary care diagnostic codes should be retained but distinguished from acute events identified using the SCORE-CVD algorithm.

&nbsp;

## Heart failure

The BHF Data Science Centre has undertaken a heart failure phenotype benchmarking project to compare different approaches to identifying heart failure using routinely collected electronic health records.

The project provides codelists and implementation code for multiple heart failure phenotype definitions, incorporating evidence from primary care records, hospital admissions and medication records.

### Codelists and implementation resources

- [Heart failure phenotype benchmarking repository](https://github.com/BHFDSC/Heart-failure-phenotype-benchmarking)
- [Heart failure phenotype codelists](https://github.com/BHFDSC/Heart-failure-phenotype-benchmarking/tree/HEAD/codelists)
- [Phenotype definitions and supporting documentation](https://github.com/BHFDSC/Heart-failure-phenotype-benchmarking/tree/HEAD/supplementary_info)
- [Data curation and phenotype implementation code](https://github.com/BHFDSC/Heart-failure-phenotype-benchmarking/tree/HEAD/curation_code)
- [Exeter heart failure SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_heartfailure_final.csv)

### DIA-Core implementation

Heart failure should be identified using primary care and linked secondary care records, where available.

We recommend distinguishing recorded heart failure diagnoses from hospital admissions for heart failure, retaining dates and sources of ascertainment to support both prevalent disease ascertainment and longitudinal outcome analyses.

The choice of heart failure phenotype definition should be informed by the findings of the benchmarking project, the available data sources and the intended research application. The selected definition and any local adaptations should be documented.

&nbsp;

## Other cardiovascular disease phenotypes

Additional cardiovascular disease phenotypes can be derived using primary care diagnostic codes and linked secondary care diagnostic and procedure codes.

### Codelists

The following SNOMED CT codelists are available from the [University of Exeter CPRD codelist repository](https://github.com/Exeter-Diabetes/CPRD-Codelists).

| Phenotype | SNOMED CT codelist |
|---|---|
| Ischaemic heart disease | [Exeter IHD codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_ihd_final.csv) |
| Angina | [Exeter angina codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_angina_final.csv) |
| Transient ischaemic attack | [Exeter TIA codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_tia_final.csv) |
| Hypertension | [Exeter hypertension codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_hypertension_final.csv) |
| Peripheral arterial disease | [Exeter PAD codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_pad_final.csv) |
| Revascularisation | [Exeter revascularisation codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Comorbidities/SNOMED%20codelists/exeter_snomed_codelist_revasc_final.csv) |

Additional codelists are available from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

&nbsp;

## General implementation rules

- Check that event dates are consistent with data source coverage and patient dates of birth and death.
- Retain longitudinal information on cardiovascular events and diagnoses.
- Distinguish historical diagnostic records from acute events where possible.
- Avoid double counting events recorded across multiple data sources.
- Retain individual cardiovascular disease phenotypes to enable derivation of composite outcomes according to specific research requirements.
- Document the source, version and configuration of each codelist and phenotyping algorithm used.
- Document any limitations arising from unavailable or incomplete linked data.

See the [standardised DIA-Core input data requirements](../../../projects/Core%20dataset/data_requirements.md) for further information on the data required to implement these phenotypes.
