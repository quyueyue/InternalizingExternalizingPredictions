#!/bin/bash
#SBATCH -J HCP_PFM_perm
#SBATCH -t 24:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

bash CBIG_TRBPC_PFM_perm_wrapper_HCP.sh -i $IntExt_DIR/HCP/HCP_output_KRR/ -f $IntExt_DIR/HCP/fMRI_data/features_rs_423.mat -n 2000 -t 2000 -o $IntExt_DIR/HCP/HCP_perm_output/PFM/ -p $IntExt_DIR/HCP/behavioral_data/HCP_alldata_filtered.csv -l $IntExt_DIR/HCP/behavioral_data/HCP_423_subjects.txt -c Milgram
