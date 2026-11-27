---
title: Data requirements
---

# Data requirements for implementing the Diabetes Core Dataset

## Overview

This page defines the input data requirements for implementing the Diabetes Core Dataset (DIA-Core) using routinely collected health data.

Implementation of DIA-Core involves two main stages:

1. Ascertainment and classification of the diabetes cohort.
2. Derivation of the remaining core dataset variables.

The input data requirements described below cover both stages.

The aim is to enable Secure Data Environments (SDEs) and other data providers to map their existing data structures to a common framework, identify gaps in data availability, and facilitate consistent and reproducible implementation of DIA-Core.

The tables described below represent logical data structures rather than a prescribed database schema. Data may be held across multiple tables or combined within a single table, depending on the underlying data source. Where necessary, data can be mapped to these structures using database views or intermediate tables.

The input data required will depend on the DIA-Core variables being derived and the data sources available within each SDE. Where input variables or data sources are unavailable, the implications for implementation should be documented.

&nbsp;

## 1. Patient demographics

One row per patient.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique pseudonymous patient identifier, consistent across linked tables | String |
| date_of_birth | Patient date of birth | Date, month/year or year |
| sex | Recorded sex | Categorical |
| date_of_death | Date of death, where applicable | Date |
| ethnicity | Recorded ethnicity, where available as a demographic field | Categorical |

Ethnicity may alternatively be derived from coded clinical observations or linked secondary care data.

&nbsp;

## 2. Primary care registration

One row per patient registration period.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique patient identifier | String |
| practice_id | Pseudonymous GP practice identifier | String |
| registration_start_date | Start of registration with GP practice | Date |
| registration_end_date | End of registration with GP practice, where applicable | Date |
| data_collection_end_date | Latest date for which data are available | Date |

Information on registration and data availability is required to establish patient observation periods and distinguish potentially incident from pre-existing diabetes diagnoses.

The data collection end date may alternatively be supplied at practice or dataset level.

&nbsp;

## 3. Primary care clinical observations

One row per recorded clinical event or measurement.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique patient identifier | String |
| observation_date | Date of clinical event or measurement | Date |
| clinical_code | Code describing the clinical event or measurement | SNOMED CT |
| numeric_value | Numeric result, where applicable | Numeric |
| unit | Unit of measurement, where applicable | String or coded value |
| categorical_value | Categorical result, where applicable | String or coded value |
| event_id | Unique identifier for the clinical event | String |
| event_type | Type or source of clinical event, where available | Categorical |

This includes diagnoses, clinical measurements, laboratory results, lifestyle information and other coded clinical events.

Relevant information may be stored across separate observation, problem, diagnosis and laboratory results tables. All relevant sources should be considered when deriving DIA-Core variables.

Historical records coded using Read v2 or CTV3 may also be relevant and should be mapped or processed using appropriate codelists.

&nbsp;

## 4. Primary care medication prescriptions

One row per prescription record.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique patient identifier | String |
| prescription_date | Date of prescription | Date |
| medication_code | Code identifying the prescribed medication or device | dm+d |
| quantity | Quantity prescribed | Numeric |
| quantity_unit | Unit of prescribed quantity | String or coded value |
| dose | Prescribed dose or dosage instructions | Numeric or string |
| prescription_id | Unique prescription identifier | String |

Medication records are used both for identifying and classifying individuals with diabetes and for deriving longitudinal treatment histories.

Relevant prescriptions include glucose-lowering medications, blood pressure lowering medications, lipid lowering medications, antiplatelet therapy and continuous glucose monitoring devices.

&nbsp;

## 5. Linked secondary care data

Linked secondary care data can supplement primary care records, particularly for identifying diabetes complications and acute clinical events.

### Hospital admissions and episodes

One row per hospital episode, with information enabling episodes to be grouped into admissions or continuous inpatient spells.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique patient identifier | String |
| admission_id | Unique admission or spell identifier | String |
| episode_id | Unique hospital episode identifier | String |
| admission_date | Date of hospital admission | Date |
| discharge_date | Date of hospital discharge | Date |
| episode_start_date | Start date of hospital episode | Date |
| episode_end_date | End date of hospital episode | Date |
| admission_method | Method of admission | NHS admission method codes |
| admission_source | Source of admission | NHS admission source codes |
| discharge_method | Method of discharge | NHS discharge method codes |
| discharge_destination | Destination following discharge | NHS discharge destination codes |

### Hospital diagnoses

One row per recorded diagnosis per episode.

| Variable | Description | Format / coding system |
|---|---|---|
| episode_id | Unique hospital episode identifier | String |
| diagnosis_code | Hospital diagnosis code | ICD-10 |
| diagnosis_position | Position of diagnosis within episode | Integer |

### Hospital procedures

One row per recorded procedure per episode.

| Variable | Description | Format / coding system |
|---|---|---|
| episode_id | Unique hospital episode identifier | String |
| procedure_code | Hospital procedure code | OPCS-4 |
| procedure_date | Date of procedure | Date |
| procedure_position | Position of procedure within episode | Integer |

Additional secondary care fields may be required to implement specific cardiovascular and other phenotyping algorithms.

&nbsp;

## 6. Linked mortality data

One row per deceased patient, with information on underlying and contributory causes of death. Contributory causes may alternatively be held in a separate table with multiple rows per patient.

| Variable | Description | Format / coding system |
|---|---|---|
| patient_id | Unique patient identifier | String |
| date_of_death | Date of death | Date |
| underlying_cause_of_death | Underlying cause of death | ICD-10 |
| contributory_cause_of_death | Other recorded causes of death | ICD-10 |

Where available, national mortality registration data should be used preferentially to ascertain dates and causes of death.

&nbsp;

## 7. Input data requirements for diabetes cohort ascertainment

We recommend following the diabetes cohort ascertainment algorithm developed by the [BHF HDR UK Diabetes Data Science Catalyst (DDSC) Defining Diabetes project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/).

The following data are required to implement the full primary care diabetes cohort ascertainment algorithm:

- Patient demographics and registration information.
- Coded diabetes diagnoses.
- HbA1c measurements, including values and units.
- Insulin prescription records.

The cohort ascertainment algorithm identifies individuals meeting at least one of the following criteria:

- A recorded diabetes diagnostic code.
- Two consecutive elevated HbA1c measurements (>=48 mmol/mol) within two years.
- At least six months between the first and last recorded insulin prescriptions.

Where one or more data sources are unavailable, the algorithm may be partially implemented, but the resulting limitations in cohort ascertainment should be documented.

Further information, including codelists and algorithms for defining diabetes cases, diagnosis dates and diabetes type, is available from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/) and the [Diabetes Core Dataset implementation guidance](index.md).

&nbsp;

## 8. Mapping local data to DIA-Core

We recommend that each SDE maps its local data structures to the logical tables and variables described above before beginning implementation.

The mapping exercise should identify:

- Local source tables and variable names.
- Available clinical coding systems.
- Required transformations or recoding.
- Data coverage and historical availability.
- Missing or unavailable variables.
- Any adaptations required to implement DIA-Core algorithms.
- This mapping should be extended to cover linked secondary care and mortality data where available.

&nbsp;

## 9. General data considerations

- Patient identifiers should be consistent across all linked datasets.
- Clinical and medication codes should be stored as strings to preserve identifier precision and formatting.
- Dates should be provided at the highest resolution permitted by local information governance requirements.
- Data coverage, including start and end dates, should be documented for each source.
- Historical clinical records should be retained wherever available.
- Missing information should be distinguishable from a confirmed absence of a clinical event.
- Coding system versions and any mappings between coding systems should be documented.
- Local adaptations to codelists, data cleaning rules and phenotyping algorithms should be documented to support reproducibility.
- Derived clinical data should retain their longitudinal structure wherever possible.
