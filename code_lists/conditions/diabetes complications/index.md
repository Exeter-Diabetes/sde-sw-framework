---
title: Diabetes complications
---

## Description

Defining diabetes-related complications (retinopathy, foot complications, lower limb amputation, cardiovascular complications, chronic kidney disease, and diabetic ketoacidosis (DKA)/ hyperosmolar hyperglycaemic state (HHS)) in EHR data. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

* Retinopathy can be identified using GP clinical codes and linked secondary care diagnostic and procedure codes (including retinal photocoagulation), with severity potentially inferred where coding allows.

* Foot complications can be defined using GP diagnostic codes and supporting secondary care diagnostic for diabetic foot disease, including ulceration, infection, and related complications. Foot risk status can also be ascertained by [NHS Quality and Outcomes Framework (QOF) codes)](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/general-practice-data-hub/quality-outcomes-framework-qof).

* Lower limb amputation can be identified primarily through secondary care OPCS-4 procedure codes, distinguishing minor and major amputations.

* Cardiovascular disease can be defined using a domain-based grouping of GP and secondary care codes covering ischaemic heart disease (including myocardial infarction and angina), cerebrovascular disease (including stroke and transient ischaemic attack), heart failure, and peripheral and other arterial disease, allowing separation of distinct vascular phenotypes rather than a single composite outcome. Again, case ascertainment may be possible using NHS QOF codes. A gold-standard algorithm for defining myocardial infarction is available from the [HDR UK Stroke Data Science Catalyst](https://github.com/BHFDSC/hds_phenotypes_score_cvd_mi).

* Chronic kidney disease can be defined using eGFR calculated from serum creatinine with confirmed staging over time (see [our previous work in CPRD](https://github.com/Exeter-Diabetes/CPRD-Codelists#ckd-chronic-kidney-disease-stage)), supplemented by diagnostic codes for advanced CKD, dialysis, and kidney transplantation. Again, case ascertainment may be possible using NHS QOF codes. Gold-standard codelists and algorithms for defining CKD may become available from the [HDR UK Kidney Data Science Catalyst](https://bhfdatasciencecentre.org/areas/kidney-data-science-catalyst/) in the future.

* Diabetic ketoacidosis (DKA) and hyperosmolar hyperglycaemic state (HHS) can be identified using GP clinical codes, supplemented by linked secondary care codes from hospital admissions, which provide the primary source of confirmed severe episodes.


## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
