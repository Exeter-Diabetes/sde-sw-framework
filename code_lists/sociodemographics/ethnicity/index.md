---
title: Ethnicity
---

## Description

Defining ethnicity using routinely collected electronic health records (EHR), including primary care and linked secondary care records.

&nbsp;

## Codelists

### Primary care

We recommend using the categorised SNOMED CT ethnicity codelist developed by OpenSAFELY:

- [OpenSAFELY ethnicity SNOMED CT codelist](https://www.opencodelists.org/codelist/opensafely/ethnicity-snomed-0removed/22911876/)
- [Download codelist (CSV)](https://www.opencodelists.org/codelist/opensafely/ethnicity-snomed-0removed/22911876/download.csv)

We recommend retaining the 16-level ethnicity classification provided in the Grouping_16 field of the codelist, from which broader ethnicity categories can be derived.

Further information on the completeness and consistency of ethnicity recording in primary care is available in the [OpenSAFELY ethnicity study](https://doi.org/10.1186/s12916-024-03499-5).

### Secondary care

Ethnicity recorded in linked secondary care data should be used to supplement primary care ethnicity where missing.

Hospital ethnicity codes should be mapped to the equivalent ethnicity categories used for primary care records, retaining the original codes and data source.

&nbsp;

## Rules

- Primary care ethnicity should be used preferentially and supplemented with ethnicity recorded in linked secondary care data where missing. This approach is supported by [Mathur et al. (2014)](https://doi.org/10.1093/pubmed/fdt116), who demonstrated greater consistency of ethnicity recording in primary care than in Hospital Episode Statistics (HES).
- Retain all recorded ethnicity codes and their observation dates where available.
- Map primary care ethnicity codes to the 16-level classification using the Grouping_16 field of the OpenSAFELY codelist.
- Map secondary care ethnicity codes to an equivalent classification before combining information across data sources.
- Where multiple valid ethnicity codes are recorded, retain sufficient information to identify both the most frequently and most recently recorded ethnicity within each data source.
- Missing, unknown and not stated ethnicity should be distinguished where possible.
- Document the codelist version, ethnicity grouping and rules used to combine information from different data sources.

&nbsp;

## Recommended derived variables

For each patient, we recommend deriving:

| Variable | Description |
|---|---|
| Ethnicity code counts | Number of recorded ethnicity codes within each of the 16 ethnicity categories |
| Most recent ethnicity | Ethnicity category of the most recently recorded valid ethnicity code |
| Most recent ethnicity date | Date of the most recently recorded valid ethnicity code |
| Most frequent ethnicity | Most frequently recorded valid ethnicity category |
| Ethnicity data source | Source of the derived ethnicity information |

Where ethnicity is available from both primary and secondary care, these variables should be derived separately for each data source.

Retaining both the frequency and recency of ethnicity recording enables assessment of consistency and supports alternative approaches to ethnicity ascertainment in downstream research.

Where possible, retain the original longitudinal ethnicity records alongside these derived variables.

&nbsp;

## References

- [Mathur et al. (2014). Completeness and usability of ethnicity data in UK-based primary care and hospital databases. Journal of Public Health.](https://doi.org/10.1093/pubmed/fdt116)
- [Andrews et al. (2024). Consistency, completeness and external validity of ethnicity recording in NHS primary care records: a cohort study in 25 million patients' records at source using OpenSAFELY. BMC Medicine.](https://doi.org/10.1186/s12916-024-03499-5)
