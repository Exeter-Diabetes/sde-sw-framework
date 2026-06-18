---
title: Diabetes
---

## Description

Defining diabetes in EHR data. We recommend using codelists from the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/) (codelist also available at the HDR UK Phenotype Library [here](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/)) which categorise diabetes codes by diabetes type (type 1, type 2, NOS [not otherwise specified], other). Alternative codelists can be found on the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We recommended following the Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithms to define diabetes cases, diabetes diagnosis dates and diabetes type. An overview of the algorithms are available via the HDR UK Phenotype library [here](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/detail/) and detailed information on derivation and validation are available [here](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/). These algorithms are used in the step-by-step instructions for [defining the variables of the core dataset in GP data](../../../projects/Core%20dataset/index.md/#defining-variables-in-gp-data).

 - Diabetes cases: (1) a diabetes diagnostic code (in primary or secondary care), (2) at least six months of insulin prescription data (see [diabetes medications](../../medications/diabetes/index.md)), or (3) two consecutive elevated (>=48 mmol/mol) HbA1c measurements (see [HbA1c](../../investigations/HbA1c/index.md)).

 - Diabetes diagnosis dates: the earliest of (1) the first recorded diabetes code of any type, or (2) the first elevated (>=48 mmol/mol) HbA1c result from a qualifying pair (two results within two years), but only if this HbA1c occurred more than one year before the first diagnosis code. Using this method, diagnosis date cannot be calculated for diabetes cases with at least 6 months of insulin data who have no diabetes codes or elevated HbA1cs. We recommend removing diagnosis dates within -30 to +90 days (inclusive) of GP registration start date as they may represent pre-existing diagnoses (similar to [https://bmjopen.bmj.com/content/7/10/e017989](https://bmjopen.bmj.com/content/7/10/e017989) except we also excluded diagnoses up to 30 days before registration as our analysis in CPRD showed an excess of diagnoses in this period). We also recommend removing diagnosis dates where insulin initiation was more than a year prior to diagnosis. It may not be possible to determine diagnosis dates in some datasets if historical data is not available. Accuracy can be improved by a) ignoring codes within the year of birth for those with type 2 diabetes, and/or b) ignoring diabetes codes which clearly do not relate to diagnosis e.g. in CPRD ignore diabetes codes with obstype=4 as these represent family history.
 
 - Classifying type 1 and type 2 diabetes in those with codes for both: if not currently on insulin (no prescriptions in last 6 months) and >1 year between diagnosis and earliest insulin script, categorise as type 2. If either currently on insulin or started insulin within 1 year of diagnosis, use the ratio of type 1:type 2 codes to assign type. The DDSC algorithm evaluated three approaches to assigning type 1 based on type 1:type 2 code ratios: V2.0 (Majority rule): Type 1 codes > Type 2 codes; V2.1 (Klompas): Type 1 codes > 0.5 × Type 2 codes; V2.2 (Exeter rule): Type 1 codes ≥ 2 × Type 2 codes. V2.0 demonstrates the best balance of specificity and sensitivity for type 1 diabetes classification based on genetic validation; V2.1 and V2.2 have greater specificity but with reduced sensitivity.

* Further work needs to be carried out to classify other diabetes types within the 'Diabetes Other' classification resulting from the algorithm, e.g. we have previously ascertained type 3c cases by requiring a record of a pancreatic condition (acute pancreatitis, chronic pancreatitis, pancreatic cancer, or haemochromatosis) prior to a diagnosis of diabetes.

* Note that some patients have 'diabetes in remission' codes. These are distinct from 'diabetes resolved' codes which are sometimes used where patients have been incorrectly coded as having diabetes and have never had diabetes.
