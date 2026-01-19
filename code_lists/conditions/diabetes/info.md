# Description

This is a list of codes for diabetes: type 1, type 2 and unspecified type. It does not include codes for other types of diabetes e.g. gestational, secondary, monogenic, syndromic.

# Rules

* We check to make sure the date is within the range expected given the data source and patient DOB and death dates.

* Presence of one of these codes may not be sufficient to define diabetes cases. In primary care data, the presence of a diabetes Quality and Outcome Framework (QOF) code is more specific for true diabetes cases. In addition, specificity can be increased by removing patients with codes for other types of diabetes mellitus (gestational, secondary etc.) or diabetes insipidus, who may erroneously have diabetes mellitus codes in their records.

* Our algorithm for defining diabetes diagnosis date: the earliest of a code for diabetes, an HbA1c>=48 mmol/mol (see investigation/HbA1c) or a prescription for a glucose-lowering medication (including insulin; see medications/diabetes). It may not be possible to determine diagnosis dates in some datasets if historical data is not available. It may be possible to remove diabetes codes which clearly do not relate to diagnosis in some datasets e.g. in CPRD remove diabetes codes with obstype=4 as these represent family history. 

* Our algorithm for distinguishing between type 1 and type 2 diabetes:
  * No insulin prescriptions: Type 2
  * With at least one insulin prescription:
    * At least one Type 1 and no Type 2 codes: Type 1
    * At least one Type 2 and no Type 1 codes: Type 2
    * Mix of Type 1 and Type 2 codes: if number of Type 1 medcodes >=2 x number of Type 2 medcodes, Type 1, otherwise Type 2
    * No Type 1 or Type 2 codes: leave as 'unspecified'. If required, a probable diabetes type can be assigned as follows: where time to insulin from diagnosis available: if diagnosed <35 years of age and on insulin within 1 year of diagnosis, Type 1, otherwise Type 2; if time to insulin not available: if diagnosed <35 years and not currently taking a non-insulin glucose-lowering medication (no prescription for a non-insulin glucose-lowering medication within 6 months, Type 1, otherwise Type 2.

# Origins

* The origin of the SNOMED codelist was searching for diabetes and related codes in the SNOMED CT UK edition release 41.2.0 from NHS TRUD.

