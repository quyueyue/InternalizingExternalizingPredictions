#!/bin/bash
#SBATCH -J HBN_KRR
#SBATCH -t 1-00:00:00
#SBATCH --mem=50G
#SBATCH --partition psych_day

# This script performed 60 random replications of 10-fold nested cross-validation

# CHANGE: specify the general HBN analysis directory
HBN_dir="$IntExt_DIR/HBN/"
# CHANGE: specify the directory containing the resting-state FC data
feature_path="$HBN_dir/HBN_data_inputs/HBN_old_RSFC_combat.mat"
# CHANGE: specify the directory containing the results of the single-KRR model
outdir="$HBN_dir/HBN_old_output_KRR"
# DON'T CHANGE: 10 outer cv folds
outerFolds=10
# DON'T CHANGE: 10 inner cv folds
innerFolds=10
# CHANGE: specify the directory containing the list of 752 subjects named "HBN_752_subjects.txt"
subtxt="$HBN_dir/HBN_data_inputs/HBN_old_subjects.txt"
# CHANGE: specify the directory containing a data frame with 1. Subject (ID); 2. Gender; 3. AgeInYrs; 4. ZygositySR; 5. Family_ID; 6. Race; 7. All ASR internalizing and externalizing scales; 8. mean FD (Framewise Displacement)
scorecsv="$HBN_dir/HBN_data_inputs/HBN_CBCL_old.csv"
# CHANGE: specify the directory containing the list of covariates (AgeinYrs and FD_mean)
covtxt="$HBN_dir/HBN_data_inputs/covariates_list_HBN.txt"
# CHANGE: specify the directory containing the list of variables to predict (ASR variable names)
predvar="$HBN_dir/HBN_data_inputs/CBCL_variables_to_predict_HBN.txt"
# Name of .mat containing the values of all y variables
ymat="output_y.mat"
# Name of .mat containing the values of all covariates
covmat="output_cov.mat"

for seed in {1..60}
do
    bash CBIG_MMP_HBN_KRR.sh ${feature_path} ${outdir} ${outerFolds} ${innerFolds} ${subtxt} ${scorecsv} ${predvar} ${covtxt} ${ymat} ${covmat} ${seed}
done
