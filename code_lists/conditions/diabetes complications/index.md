---
title: Diabetes complications
---

## Description

Defining diabetes-related complications (retinopathy, foot complications, lower limb amputation, cardiovascular complications, chronic kidney disease, and diabetic ketoacidosis (DKA)/ hyperosmolar hyperglycaemic state (HHS)) in EHR data. We recommend using codelists/algorithms from the [HDR UK Phenotype Library](https://phenotypes.healthdatagateway.org/) or [OpenCodelists](https://www.opencodelists.org/), in conjunction with the below advice.

* Retinopathy can be identified using GP clinical codes and linked secondary care diagnostic and procedure codes (including retinal photocoagulation), with severity potentially inferred where coding allows.

* [Foot complications](../foot%20complications/index.md), including ulceration, infection, loss of sensation and absent foot pulses, can be identified using primary care clinical codes, QOF foot examination codes and linked secondary care data.

* [Lower limb amputation](../foot%20complications/index.md#lower-limb-amputation) can be identified primarily through secondary care OPCS-4 procedure codes, supplemented by primary care records, distinguishing minor and major amputations where coding allows.

* [Cardiovascular disease](../cardiovascular%20disease/index.md) can be defined using primary care and linked secondary care and mortality records. We recommend using the BHF Data Science Centre SCORE-CVD phenotyping algorithms for identifying myocardial infarction and stroke events, alongside resources developed through the Heart Failure Phenotype Benchmarking project.

* [Chronic kidney disease](../chronic%20kidney%20disease/index.md) can be identified and staged using the phenotyping algorithm developed by the BHF Data Science Centre Kidney Data Science Catalyst, incorporating laboratory measurements, diagnostic codes and evidence of dialysis and kidney transplantation.

* Diabetic ketoacidosis (DKA) and hyperosmolar hyperglycaemic state (HHS) can be identified using GP clinical codes, supplemented by linked secondary care codes from hospital admissions, which provide the primary source of confirmed severe episodes.


## Rules

* Check to make sure the date is within the range expected given the data source and patient DOB and death dates.
