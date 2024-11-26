# 60 Random Initiations of 10-fold Cross-Validated Single-Kernel Regression workflow in HBN Analyses

Functions in this folder perform single-kernel ridge regression nested cross validation used in the HBN analyses. 

Suppose that the outputs of the KRR function goes to `$IntExt_DIR/HBN/HBN_output_KRR/`.

## Inputs
Suppose that all input files are under the directory `$IntExt_DIR/HBN/HBN_data_inputs/`

The resting-state functional connectivity data for the 423 HBN adolescents is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_old_RSFC.mat`. After harmonizing the site differences using neuroCombat.R, the output is `HBN_old_RSFC_combat.mat` and will be used as the input to the KRR function.

The subject IDs of the 229 HBN adolescents used in the analysis is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_229_subjects.txt`.

The data .csv containing subject IDs, site information behavioral variables and covariates is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_CBCL.csv`.

The .txt file containing the names of covariates (in our analyses they are Sex and Age, corresponding to column names in `HBN_CBCL.csv`) is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `covariates_list_HBN.txt`.

The .txt file containing the list of variable names to predict (the names of the CBCL internalizing and externalizing measures) is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `CBCL_variables_to_predict_HBN.tx`.

## Implementation
Run `sbatch CBIG_MMP_HBN_KRR_slurm.sh`
