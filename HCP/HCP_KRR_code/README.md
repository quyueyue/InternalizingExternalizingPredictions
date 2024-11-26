# 60 Random Initiations of 10-fold Cross-Validated Single-Kernel Regression workflow in HCP Analyses

Functions in this folder perform single-kernel ridge regression nested cross validation used in the HCP analyses. 

Suppose that the outputs of the KRR function goes to `$IntExt_DIR/HCP/HCP_output_KRR/`.

## Inputs
Suppose that all input files are under the directory `$IntExt_DIR/HCP/HCP_data_inputs/`

The resting-state functional connectivity data for the 423 HCP adults is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `features_rs_423.mat`.

The subject IDs of the 423 HCP adults used in the analysis is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `HCP_423_subjects.txt`.

The data .csv containing 1) HCP Subject ID; 2) Gender; 3) AgeInYrs; 4) ZygositySR; 5) Family_ID; 6) Race; 7) All ASR internalizing and externalizing measures is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `HCP_alldata_filtered.csv`.

The .txt file containing the list of covariates (in our analyses they are AgeInYrs and Gender) is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `covariates_list.txt`.

The .txt file containing the list of variable names to predict (the names of the ASR internalizing and externalizing measures) is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `variables_to_predict_hcp.txt`.

## Implementation
Run `sbatch CBIG_MMP_HCP_KRR_slurm.sh`
