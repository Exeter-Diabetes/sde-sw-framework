---
title: Diabetes
---

## Description

A list of codes for all diabetes types. We do not provide a specific codelist but recommend using that from the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/). Alternative codelist can be found on the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* We recommended defining diabetes cases as per the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithm](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/): (1) a diabetes diagnostic code (in primary or secondary care), (2) at least six months of insulin prescription data, or (3) two consecutive elevated HbA1c results of 48 or above.

* We recommend defining diabetes diagnosis date as per the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithm](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/): as the earliest of: (1) the first recorded diabetes code of any type, or (2) the first elevated HbA1c result from a qualifying pair (two results within two years), but only if this HbA1c occurred more than one year before the first diagnosis code. It may not be possible to determine diagnosis dates in some datasets if historical data is not available. Accuracy can be improved by a) ignoring codes within the year of birth for those with type 2 diabetes, and/or b) ignoring diabetes codes which clearly do not relate to diagnosis e.g. in CPRD ignore diabetes codes with obstype=4 as these represent family history.

* We recommend distinguishing between type 1 and type 2 diabetes in those with codes for both as per the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) algorithm](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/):


*
* Our algorithm for distinguishing between type 1 and type 2 diabetes:
  * No insulin prescriptions: Type 2
  * With at least one insulin prescription:
    * At least one Type 1 and no Type 2 codes: Type 1
    * At least one Type 2 and no Type 1 codes: Type 2
    * Mix of Type 1 and Type 2 codes: if number of Type 1 medcodes >=2 x number of Type 2 medcodes, Type 1, otherwise Type 2
    * No Type 1 or Type 2 codes: leave as 'unclassified'. If required, a probable diabetes type can be assigned as follows: where time to insulin from diagnosis available: if diagnosed <35 years of age and on insulin within 1 year of diagnosis, Type 1, otherwise Type 2; if time to insulin not available: if diagnosed <35 years and not currently taking a non-insulin glucose-lowering medication (no prescription for a non-insulin glucose-lowering medication within 6 months, Type 1, otherwise Type 2.
