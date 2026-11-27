---
title: Smoking status
---

## Description

Defining smoking status using routinely collected electronic health records (EHR).

&nbsp;

## Codelists

We recommend using the categorised SNOMED CT codelist developed by the University of Exeter:

- [Exeter smoking SNOMED CT codelist](https://github.com/Exeter-Diabetes/CPRD-Codelists/blob/HEAD/Medcodes/Sociodemographic%20and%20lifestyle/SNOMED%20codelists/exeter_snomed_codelist_smoking_final.csv)

The codelist includes a category field describing smoking status.

When using this codelist with SNOMED CT-coded data, extract the snomedcode and category fields, remove trailing hash (#) characters from code identifiers and remove duplicate code-category combinations. Check for codes assigned to multiple categories before implementation.

&nbsp;

## Rules

- Check that observation dates are consistent with data source coverage and patient dates of birth and death.
- We recommend using three main smoking categories: non-smoker, ex-smoker and active smoker.
- Active smokers may be further subdivided according to smoking intensity (e.g. cigarettes per day), where this information is available.
- Retain all recorded smoking status categories and observation dates.
- When deriving smoking status at a particular date, use the most recently recorded information on or before that date.
- If non-smoker and ex-smoker are recorded on the same date, categorise that date as ex-smoker.
- If active smoker is recorded on the same date as non-smoker or ex-smoker, look at the next most recent date. Repeat until a date with an unambiguous category is found.
- If no unambiguous dated recording is available, assign unknown.
- If the selected status is non-smoker but the individual has previously been recorded as an active smoker before the selected date, categorise as ex-smoker.
- Individuals without recorded smoking status should be classified as missing or unknown.

These rules are based on the [Exeter CPRD smoking algorithm](https://github.com/Exeter-Diabetes/CPRD-Codelists#smoking). Assigning unknown where no unambiguous date is available is an explicit fallback for DIA-Core.
