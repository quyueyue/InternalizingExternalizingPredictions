#!/bin/bash
#SBATCH -J HCP_PFM_perm
#SBATCH -t 7-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --partition psych_week

bash CBIG_TRBPC_PFM_perm_wrapper_HCP.sh -i $IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/ -f $IntExt_DIR/HCP/HCP_data_inputs/features_rs_752.mat -n 1000 -t 2000 -o $IntExt_DIR/HCP/HCP_perm_output/PFM/ -p $IntExt_DIR/HCP/HCP_data_inputs/HCP_alldata.csv -l $IntExt_DIR/HCP/HCP_data_inputs/HCP_752_subjects.txt -c Milgram
