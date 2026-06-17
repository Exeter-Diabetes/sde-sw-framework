---
title: Diabetes
---

## Description

Identifying and cleaning prescriptions for non-insulin glucose-lowering medication and insulin in EHR. We recommend using codelists from the [Defining Diabetes HDR UK Diabetes Data Science Catalyst (DDSC) project](https://bhf-dsc-hds.shinyapps.io/hds_phenotypes_diabetes/) (codelists also available at the HDR UK Phenotype Library [here](https://phenotypes.healthdatagateway.org/phenotypes/PH4062/version/9273/)). Alternative codelists can be found on the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) and [OpenCodelists](https://www.opencodelists.org/).

## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* In patients with diabetes, insulin prescriptions are used in the algorithm to define diabetes cases and diabetes type - see conditions/diabetes.
