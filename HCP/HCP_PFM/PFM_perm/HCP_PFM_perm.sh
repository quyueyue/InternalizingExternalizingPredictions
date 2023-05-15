#!/bin/bash
#SBATCH -J HCP_PFM_perm
#SBATCH -t 7-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --partition psych_week

bash CBIG_TRBPC_PFM_perm_wrapper_HCP.sh -i /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_output_KRR/KRR_features_rs_752/ -f /gpfs/milgram/project/holmes/yq222/FYP/HCP/FC_data/features_rs_752.mat -n 1000 -t 2000 -o /gpfs/milgram/project/holmes/yq222/FYP/HCP/permutations/PFM_KRR/ -p /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_alldata.csv -l /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_752_subjects.txt -c Milgram
