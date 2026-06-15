---
title: Diabetes
---

## Description

A list of codes for all diabetes types. We do not provide a specific codelist but recommend using that from the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/). Alternative codelists can be found on the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We recommended following the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithm](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/) to define diabetes cases, diabetes diagnosis dates and diabetes type:

 - Diabetes cases: (1) a diabetes diagnostic code (in primary or secondary care), (2) at least six months of insulin prescription data (see [Insulin](conditions/medications/diabetes/index.md)), or (3) two consecutive elevated HbA1c (see HbA1c) results of 48 or above.

 - Diabetes diagnosis dates: the earliest of (1) the first recorded diabetes code of any type, or (2) the first elevated HbA1c result from a qualifying pair (two results within two years), but only if this HbA1c occurred more than one year before the first diagnosis code. It may not be possible to determine diagnosis dates in some datasets if historical data is not available. Accuracy can be improved by a) ignoring codes within the year of birth for those with type 2 diabetes, and/or b) ignoring diabetes codes which clearly do not relate to diagnosis e.g. in CPRD ignore diabetes codes with obstype=4 as these represent family history.
 
 - Classifying type 1 and type 2 diabetes in those with codes for both: if not currently on insulin (no prescriptions in last 6 months) and >1 year between diagnosis and earliest insulin script, categorise as type 2. If either currently on insulin or started insulin within 1 year of diagnosis, use the ratio of type 1:type 2 codes to assign type. The DDSC algorithm evaluated three approaches to assigning type 1 based on type 1:type 2 code ratios: V2.0 (Majority rule): Type 1 codes > Type 2 codes; V2.1 (Klompas): Type 1 codes > 0.5 × Type 2 codes; V2.2 (Exeter rule): Type 1 codes ≥ 2 × Type 2 codes. V2.0 demonstrates the best balance of specificity and sensitivity for type 1 diabetes classification based on genetic validation; V2.1 and V2.2 have greater specificity but with reduced sensitivity.
