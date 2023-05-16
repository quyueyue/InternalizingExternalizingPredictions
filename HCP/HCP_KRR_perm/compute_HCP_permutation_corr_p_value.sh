#!/bin/bash
#SBATCH -J HCP_KRR_perm_compute_pval
#SBATCH -t 1:00:00
#SBATCH --mem=10G
#SBATCH --partition psych_day

ref_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_output_KRR/"
behav_ind=1:18
outstem="KRR_features_rs_752"
perm_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP/permutations/KRR_features_rs_752/"
seeds_total=60

script_dir=$(dirname "$(readlink -f "$0")")
matlab -nodesktop -nosplash -nodisplay -r " try addpath('$script_dir'); CBIG_MMP_compute_HCP_permutation_corr_p_value( \
'$ref_dir', $behav_ind, '$outstem', '$perm_dir', $seeds_total); catch ME; display(ME.message); end; exit; "