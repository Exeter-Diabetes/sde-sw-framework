# Phenotype Data Flow

The diagram below illustrates table dependencies and processing
steps used to construct the phenotype cohort.

Any change to SQL logic should be reflected here.

```mermaid
flowchart TD

%% -------------------
%% Source Tables
%% ------------------- 
A[primary_care_patient_demographics]
B[primary_care_encounter]
C[primary_care_medications]

%% -------------------
%% Step 1
%% -------------------
    subgraph Step_1["step_1_clean_diabetes_codes.sql"]
        D[eligible_patients]
        E[diabetes_events]
    end

%% -------------------
%% Step 2
%% -------------------
    subgraph Step_2["step_2_earliest_clean_diabetes_code_per_patient.sql"]
        F[earliest_diabetes_code]
    end

%% -------------------
%% Step 3
%% -------------------
    subgraph Step_3["step_3_clean_hba1c_measures.sql"]
        G[hba1c_events_raw]
        H[hba1c_events_clean]
        I[hba1c_events_dedup] 
    end

%% -------------------
%% Step 4
%% -------------------
    subgraph Step_4["step_4_glucose_medication.sql"]
        J[insulin_medications_raw]
        K[non_insulin_medications_raw]
        L[insulin_medications_clean]
        M[non_insulin_medications_clean]
    end

%% -------------------
%% Step 5
%% -------------------
    subgraph Step_5["step_5_earliest_hba1c_measure.sql"]
        N[earliest_hba1c_per_patient]
    end

%% -------------------
%% Step 6
%% -------------------
    subgraph Step_6["step_6_earliest_glucose_medication.sql"]
        O[earliest_insulin_per_patient]
        P[earliest_non_insulin_per_patient]
    end

%% -------------------
%% Step 7
%% -------------------
    subgraph Step_7["step_7_diabetes_diagnosis_dates.sql"]
        Q[earliest_glucose_med_per_patient]
        R[diabetes_diagnosis_dates]
    end

%% -------------------
%% Step 8
%% -------------------
    subgraph Step_8["step_8_diabetes_code_counts_per_patient.sql"]
        S[diabetes_code_counts_per_patient]
    end

%% -------------------
%% Data Flow
%% -------------------
    A --> D
    B --> E
    B --> G
    G --> H
    H --> I
    I --> N
    C --> J
    C --> K
    J --> L
    K --> M
    L --> O
    M --> P
    I --> R
    O --> Q
    P --> Q
    F --> R
    E --> S
```


## Data

* [1 Clean diabetes codes](step_1_clean_diabetes_codes.sql)
* [2 Earliest clean diabetes code per patient](step_2_earliest_clean_diabetes_code_per_patient.sql)
* [3 Clean HbA1c measurements](step_3_clean_hba1c_measures.sql)
* [4 Glucose-lowering medication](step_4_glucose_medication.sql)
* [5 Earliest high HbA1c measurements](step_5_earliest_hba1c_measure.sql)
* [6 Earliest glucose-lowering medication](step_6_earliest_glucose_medication.sql)
* [7 Diabetes diagnosis dates](step_7_diabetes_diagnosis_dates.sql)
* [8 Diabetes counts per patient](step_8_diabetes_code_counts_per_patient.sql)
