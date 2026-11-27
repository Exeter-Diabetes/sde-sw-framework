---
title: Alcohol status
---

## Description

Defining alcohol consumption status using routinely collected electronic health records (EHR).

&nbsp;

## Codelists

We recommend using the categorised SNOMED CT codelist developed by the University of Exeter:

- [Exeter alcohol SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Sociodemographic%20and%20lifestyle/SNOMED%20codelists/exeter_snomed_codelist_alcohol_final.csv)

The codelist includes a category field distinguishing the following alcohol consumption levels:

| Codelist category | Alcohol consumption level |
|---|---|
| AlcoholConsumptionLevel0 | None |
| AlcoholConsumptionLevel1 | Within limits |
| AlcoholConsumptionLevel2 | Excess |
| AlcoholConsumptionLevel3 | Harmful |

When using this codelist with SNOMED CT-coded data, extract the snomedcode and category fields, remove trailing hash (#) characters from code identifiers and remove duplicate code-category combinations. Check for codes assigned to multiple categories before implementation.

&nbsp;

## Rules

- Check that observation dates are consistent with data source coverage and patient dates of birth and death.
- Retain all recorded alcohol consumption categories and observation dates.
- When deriving alcohol consumption status at a particular date, use the most recently recorded information on or before that date.
- If a patient has previously been recorded with a level 3 code, categorise as level 3, reflecting a history of harmful alcohol consumption.
- If multiple levels are recorded on the most recent date, take the highest level.
- Individuals without recorded alcohol consumption information should be classified as missing or unknown.
