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
- If the most recent code indicates non-smoker but the individual has previously been recorded as an active smoker, categorise as ex-smoker.
- Individuals without recorded smoking status should be classified as missing or unknown.
