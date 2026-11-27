---
title: Diabetes
---

## Description

Defining diabetes in EHR data. We recommend using codelists from the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/) (codelist also available at the HDR UK Phenotype Library [here](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/)) which categorise diabetes codes by diabetes type (type 1, type 2, NOS [not otherwise specified], other). Alternative codelists can be found on the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We recommend following the Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithms to define diabetes cases, diabetes diagnosis dates and diabetes type. An overview of the algorithms are available via the HDR UK Phenotype library [here](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/detail/) and detailed information on derivation and validation are available [here](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/). These algorithms are used in the step-by-step instructions for [diabetes cohort ascertainment and classification](../../../projects/Core%20dataset/diabetes_cohort.md).

 - Diabetes cases: (1) a diabetes diagnostic code (in primary or secondary care), (2) at least six months of insulin prescription data (see [diabetes medications](../../medications/diabetes%20medications/index.md)), or (3) two consecutive elevated (>=48 mmol/mol) HbA1c measurements (see [HbA1c](../../investigations/HbA1c/index.md)).

 - Diabetes diagnosis dates: the earliest of (1) the first recorded diabetes code of any type, or (2) the first elevated (>=48 mmol/mol) HbA1c result from a qualifying pair (two results within two years), but only if this HbA1c occurred more than one year before the first diagnosis code. Using this method, diagnosis date cannot be calculated for diabetes cases with at least 6 months of insulin data who have no diabetes codes or elevated HbA1cs. We recommend removing diagnosis dates within -30 to +90 days (inclusive) of GP registration start date as they may represent pre-existing diagnoses (similar to [https://bmjopen.bmj.com/content/7/10/e017989](https://bmjopen.bmj.com/content/7/10/e017989) except we also excluded diagnoses up to 30 days before registration as our analysis in CPRD showed an excess of diagnoses in this period). We also recommend removing diagnosis dates where insulin initiation was more than a year prior to diagnosis. It may not be possible to determine diagnosis dates in some datasets if historical data is not available. Accuracy can be improved by a) ignoring codes within the year of birth for those with type 2 diabetes, and/or b) ignoring diabetes codes which clearly do not relate to diagnosis e.g. in CPRD ignore diabetes codes with obstype=4 as these represent family history.
 
 - Classifying type 1 and type 2 diabetes in those with codes for both: if not currently on insulin (no prescriptions in last 6 months) and >1 year between diagnosis and earliest insulin script, categorise as type 2. If either currently on insulin or started insulin within 1 year of diagnosis, use the ratio of type 1:type 2 codes to assign type. The DDSC algorithm evaluated three approaches to assigning type 1 based on type 1:type 2 code ratios: V2.0 (Majority rule): Type 1 codes > Type 2 codes; V2.1 (Klompas): Type 1 codes > 0.5 × Type 2 codes; V2.2 (Exeter rule): Type 1 codes ≥ 2 × Type 2 codes. V2.0 demonstrates the best balance of specificity and sensitivity for type 1 diabetes classification based on genetic validation; V2.1 and V2.2 have greater specificity but with reduced sensitivity.

* Further work needs to be carried out to classify other diabetes types within the 'Diabetes Other' classification resulting from the algorithm, e.g. we have previously ascertained type 3c cases by requiring a record of a pancreatic condition (acute pancreatitis, chronic pancreatitis, pancreatic cancer, or haemochromatosis) prior to a diagnosis of diabetes.

&nbsp;

## Diabetes remission and resolution

Diabetes remission should be recorded separately from the underlying diabetes type. Diabetes resolved codes are distinct from remission codes and may be used where a previous diabetes diagnosis was incorrect.

The following SNOMED CT codes are included in the DDSC diabetes diagnostic codelists:

| SNOMED CT code | Description | Event category | Diabetes type associated with code |
|---|---|---|---|
| 703136005 | Diabetes mellitus in remission | Remission | Unspecified |
| 703137001 | Type I diabetes mellitus in remission | Remission | Type 1 |
| 703138006 | Type II diabetes mellitus in remission | Remission | Type 2 |
| 315051004 | Diabetes resolved | Resolved | Unspecified |

Sources: [DDSC type 1 diabetes codelist](https://github.com/BHFDSC/hds_phenotypes_diabetes/blob/main/hds_phenotypes_diabetes/1.%20codelists/diabetes_type1.csv), [DDSC type 2 diabetes codelist](https://github.com/BHFDSC/hds_phenotypes_diabetes/blob/main/hds_phenotypes_diabetes/1.%20codelists/diabetes_type2.csv) and [DDSC diabetes NOS codelist](https://github.com/BHFDSC/hds_phenotypes_diabetes/blob/main/hds_phenotypes_diabetes/1.%20codelists/diabetes_nos.csv).

Identify these codes explicitly rather than filtering on the DDSC Remission label, which does not consistently distinguish remission from resolution or identify type-specific remission codes.

### DIA-Core implementation

Retain all recorded remission and resolution events in a longitudinal table:

| Variable | Description |
|---|---|
| patient_id | Pseudonymous patient identifier |
| event_date | Date of recorded remission or resolution |
| clinical_code | Original SNOMED CT code |
| event_category | Remission or resolved |
| code_diabetes_type | Diabetes type associated with the code (type 1, type 2 or unspecified) |

### Rules

- Retain remission and resolution codes as separate event categories, including all recorded instances and dates.
- Preserve the underlying diabetes type and diagnosis date derived through the diabetes cohort ascertainment algorithm.
- Do not use a historical remission code alone to infer current remission status.
- Do not automatically exclude individuals from the diabetes cohort solely because a diabetes resolved code is recorded.
- The initial DIA-Core implementation captures recorded remission. Deriving remission from longitudinal HbA1c and glucose-lowering medication history, including the end of remission, is outside the scope of this initial implementation.

For CPRD-specific implementations, an [Exeter remission and resolution medcode codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Diabetes/exeter_medcodelist_diabetes_remission.txt) is also available; the SNOMED CT codes above are recommended for DIA-Core.
