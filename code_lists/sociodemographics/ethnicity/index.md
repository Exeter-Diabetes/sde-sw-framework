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

## Recommended default classification

For a single patient-level ethnicity variable, we recommend adapting the [Exeter CPRD ethnicity algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists#ethnicity) to the 16-category classification:

1. Within each data source, exclude missing, unknown and not stated categories from the classification counts. Include valid ethnicity categories even where the observation date is unavailable.
2. Assign the most frequently recorded valid ethnicity category.
3. If multiple categories are equally frequent, select the category with the most recent dated recording among the tied categories.
4. If the tie cannot be resolved using available dates, including where conflicting tied categories occur on the same most recent date, assign unknown.
5. Derive ethnicity separately in primary and secondary care. Use the primary care classification preferentially, supplementing with the secondary care classification if primary care ethnicity is missing or unknown.
6. Derive broader ethnicity groupings from the assigned 16-category classification to ensure consistency between grouping levels.

Retain the source-specific counts and recency variables to support alternative classifications. The default is adapted from the Exeter approach rather than a requirement to reproduce its separate five-category and QRISK2 algorithms. Alternative frequency- and recency-based approaches have been evaluated by [Shiekh et al. (2025)](https://doi.org/10.1136/bmjopen-2025-100533).

&nbsp;

## Recommended derived variables

For each patient, we recommend deriving:

| Variable | Description |
|---|---|
| Ethnicity code counts | Number of recorded ethnicity codes within each of the 16 ethnicity categories |
| Most recent ethnicity | Ethnicity category of the most recently recorded valid ethnicity code |
| Most recent ethnicity date | Date of the most recently recorded valid ethnicity code |
| Most frequent ethnicity | Most frequently recorded valid ethnicity category |
| Assigned ethnicity | Recommended 16-category ethnicity derived using the default classification above |
| Ethnicity data source | Source of the derived ethnicity information |

Where ethnicity is available from both primary and secondary care, these variables should be derived separately for each data source.

Retaining both the frequency and recency of ethnicity recording enables assessment of consistency and supports alternative approaches to ethnicity ascertainment in downstream research.

Where possible, retain the original longitudinal ethnicity records alongside these derived variables.

&nbsp;

## References

- [Mathur et al. (2014). Completeness and usability of ethnicity data in UK-based primary care and hospital databases. Journal of Public Health.](https://doi.org/10.1093/pubmed/fdt116)
- [Andrews et al. (2024). Consistency, completeness and external validity of ethnicity recording in NHS primary care records: a cohort study in 25 million patients' records at source using OpenSAFELY. BMC Medicine.](https://doi.org/10.1186/s12916-024-03499-5)
- [Shiekh SI, Williams R, Axson EL (2025). Development of an algorithm for ethnicity recording in cohorts from the UK Clinical Practice Research Datalink primary care and linked Hospital Episode Statistics databases. BMJ Open.](https://doi.org/10.1136/bmjopen-2025-100533)
