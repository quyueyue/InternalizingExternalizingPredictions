# 60 Random Initiations of 10-fold Cross-Validated Single-Kernel Regression workflow in HCP Analyses

Functions in this folder perform single-kernel ridge regression nested cross validation used in the HCP analyses. 

## Inputs
Suppose that all input files are under the directory `$IntExt_DIR/HCP/behavioral_data/` and `$IntExt_DIR/HCP/fMRI_data/`

The resting-state functional connectivity data for the 423 HCP adults is stored under 
# CHANGE: specify the general HCP analysis directory
HCP_dir="$IntExt_DIR/HCP/"
# CHANGE: specify the directory containing the resting-state FC data named "features_rs_423.mat"
feature_path="$HCP_dir/fMRI_data/features_rs_423.mat"
# CHANGE: specify the directory containing the results of the single-KRR model
outdir="$HCP_dir/HCP_output_KRR"
# DON'T CHANGE: 10 outer cv folds
outerFolds=10
# DON'T CHANGE: 10 inner cv folds
innerFolds=10
# CHANGE: specify the directory containing the list of 752 subjects named "HCP_752_subjects.txt"
subtxt="$HCP_dir/behavioral_data/HCP_423_subjects.txt"
# CHANGE: specify the directory containing a data frame with 1. Subject (ID); 2. Gender; 3. AgeInYrs; 4. ZygositySR; 5. Family_ID; 6. Race; 7. All ASR internalizing and externalizing scales; 8. mean FD (Framewise Displacement)
scorecsv="$HCP_dir/behavioral_data/HCP_alldata_filtered.csv"
# CHANGE: specify the directory containing the list of covariates (AgeinYrs and FD_mean)
covtxt="$HCP_dir/behavioral_data/covariates_list.txt"
# CHANGE: specify the directory containing the list of variables to predict (ASR variable names)
predvar="$HCP_dir/behavioral_data/variables_to_predict_hcp.txt"






and all outputs of the KRR go to `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/` where KRR_features_rs_752 is the outstem,

## Implementation
Run `sbatch CBIG_MMP_HCP_KRR_slurm.sh`
