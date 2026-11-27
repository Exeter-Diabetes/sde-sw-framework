---
title: Ethnicity
---

## Description

Defining ethnicity using routinely collected electronic health records (EHR).

&nbsp;

## Codelists

We recommend using the categorised SNOMED CT ethnicity codelist developed by OpenSAFELY:

- [OpenSAFELY ethnicity SNOMED CT codelist](https://www.opencodelists.org/codelist/opensafely/ethnicity-snomed-0removed/22911876/)
- [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/phenotypes/PH3418/version/8446/detail/)

The codelist includes mappings to detailed (16-category) and broader ethnicity groupings.

Further information on the development and evaluation of ethnicity codelists is available in the OpenSAFELY study [Consistency, completeness and external validity of ethnicity recording in NHS primary care records](https://doi.org/10.1186/s12916-024-03499-5).

&nbsp;

## Rules

- Primary care recorded ethnicity should be used preferentially and supplemented with ethnicity recorded in linked secondary care data where missing, as recommended in [previous research](https://pmc.ncbi.nlm.nih.gov/articles/PMC4245896/).
- If multiple valid ethnicities are recorded for an individual, we recommend using the most recently recorded ethnicity within the preferred data source.
- Retain the original recorded ethnicity and the derived ethnicity category.
- Where possible, retain the most granular ethnicity category available to enable different groupings for downstream research.
- Ethnicity groupings should be aligned with recognised UK ethnicity classifications, such as [UK Government Census categories](https://www.ethnicity-facts-figures.service.gov.uk/style-guide/ethnic-groups/), where appropriate.
- Missing, unknown and not stated ethnicity should be distinguished where possible.
- Document the codelist version, ethnicity grouping and rules used to combine information from different data sources.
