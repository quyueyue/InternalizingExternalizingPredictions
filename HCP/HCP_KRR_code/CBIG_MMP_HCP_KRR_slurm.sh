#!/bin/bash
#SBATCH -J HCP_KRR
#SBATCH -t 7-00:00:00
#SBATCH --cpus-per-task=20
#SBATCH --mem=50G
#SBATCH --partition psych_week

HCP_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP"
feature_path="$HCP_dir/FC_data/features_rs_752"
outdir="$HCP_dir/HCP_output_KRR"
outerFolds=10
innerFolds=10
subtxt="$HCP_dir/HCP_752_subjects.txt"
scorecsv="$HCP_dir/HCP_alldata.csv"
covtxt="$HCP_dir/covariates_list.txt"
predvar="$HCP_dir/variables_to_predict_hcp.txt"
ymat="output_y.mat"
covmat="output_cov.mat"

for seed in {1..60}
do
    bash CBIG_MMP_HCP_KRR.sh ${feature_path} ${outdir} ${outerFolds} ${innerFolds} ${subtxt} ${scorecsv} ${predvar} ${covtxt} ${ymat} ${covmat} ${seed}
done
