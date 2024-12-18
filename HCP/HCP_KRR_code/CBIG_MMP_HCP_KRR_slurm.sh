#!/bin/bash
#SBATCH -J HCP_KRR
#SBATCH -t 7-00:00:00
#SBATCH --mem=50G
#SBATCH --partition psych_week

# This script performed 60 random replications of 10-fold nested cross-validation

# CHANGE: specify the general HCP analysis directory
HCP_dir="$IntExt_DIR/HCP/"
# CHANGE: specify the directory containing the resting-state FC data named "features_rs_423.mat"
feature_path="$HCP_dir/HCP_data_inputs/features_rs_423.mat"
# CHANGE: specify the directory containing the results of the single-KRR model
outdir="$HCP_dir/HCP_output_KRR"
# DON'T CHANGE: 10 outer cv folds
outerFolds=10
# DON'T CHANGE: 10 inner cv folds
innerFolds=10
# CHANGE: specify the directory containing the list of 423 subjects named "HCP_423_subjects.txt"
subtxt="$HCP_dir/HCP_data_inputs/HCP_423_subjects.txt"
# CHANGE: specify the directory containing a data frame with 1. Subject (ID); 2. Gender; 3. AgeInYrs; 4. ZygositySR; 5. Family_ID; 6. Race; 7. All ASR internalizing and externalizing scales;
scorecsv="$HCP_dir/HCP_data_inputs/HCP_alldata_filtered.csv"
# CHANGE: specify the directory containing the list of covariates (AgeinYrs and Gender)
covtxt="$HCP_dir/HCP_data_inputs/covariates_list.txt"
# CHANGE: specify the directory containing the list of variables to predict (ASR variable names)
predvar="$HCP_dir/HCP_data_inputs/variables_to_predict_hcp.txt"
# Name of .mat containing the values of all y variables
ymat="output_y.mat"
# Name of .mat containing the values of all covariates
covmat="output_cov.mat"

for seed in {1..60}
do
    bash CBIG_MMP_HCP_KRR.sh ${feature_path} ${outdir} ${outerFolds} ${innerFolds} ${subtxt} ${scorecsv} ${predvar} ${covtxt} ${ymat} ${covmat} ${seed}
done
