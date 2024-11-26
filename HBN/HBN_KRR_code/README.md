# 60 Random Initiations of 10-fold Cross-Validated Single-Kernel Regression workflow in HBN Analyses

Functions in this folder perform single-kernel ridge regression nested cross validation used in the HBN analyses. 

Suppose that the outputs of the KRR function goes to `$IntExt_DIR/HBN/HBN_output_KRR/`.

## Inputs
Suppose that all input files are under the directory `$IntExt_DIR/HBN/HBN_data_inputs/`

The resting-state functional connectivity data for the 423 HBN adolescents is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `features_rs_423.mat`.

The subject IDs of the 423 HBN adolescents used in the analysis is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_423_subjects.txt`.

The data .csv containing 1) HBN Subject ID; 2) Gender; 3) AgeInYrs; 4) ZygositySR; 5) Family_ID; 6) Race; 7) All ASR internalizing and externalizing measures is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_alldata_filtered.csv`.

The .txt file containing the names of covariates (in our analyses they are AgeInYrs and Gender, corresponding to column names in `HBN_alldata_filtered`) is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `covariates_list.txt`.

The .txt file containing the list of variable names to predict (the names of the ASR internalizing and externalizing measures) is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `variables_to_predict_HBN.txt`.

## Implementation
Run `sbatch CBIG_MMP_HBN_KRR_slurm.sh`
