---
title: ALT (Alanine aminotransferase)
---

## Description

Identifying and cleaning ALT (Alanine aminotransferase) values in EHR data.

## Rules

To note: steps 1-3 below should be carried out in this order to produce a standardised end result:

1. Standardise values to U/L using recorded unit information where available.
2. Remove values less than 0 and greater than 200 U/L as these are considered implausible.
3. If multiple values are recorded on the same day for a patient, take the mean.

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.

## Origins

* The origin of the SNOMED codelist was the Pathology Bounded Code List (PBCL).

## Data

* [ALT SNOMED](alt_snomed.csv)
