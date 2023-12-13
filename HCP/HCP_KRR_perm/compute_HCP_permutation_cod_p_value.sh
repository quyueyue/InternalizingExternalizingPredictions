#!/bin/bash
#SBATCH -J compute_HCP_perm_cod_pval
#SBATCH -t 1:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

# CHANGE: please specify the directory containing the single-KRR outputs
# regression_results_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_output_KRR/"
regression_results_dir="$IntExt_DIR/HCP/HCP_output_KRR/"
# DON'T CHANGE: behavioral indices (18 behaviors in total)
behav_ind=1:7
# DON'T CHANGE: outstem
outstem="KRR_features_rs_752"
# CHANGE: please specify the directory containing single-KRR permutation results
perm_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_perm_output/pred_acc/KRR_features_rs_752/"
seeds_total=60

script_dir=$(dirname "$(readlink -f "$0")")
matlab -nodesktop -nosplash -nodisplay -r " try addpath('$script_dir'); CBIG_MMP_compute_HCP_permutation_cod_p_value( \
'$regression_results_dir', $behav_ind, '$outstem', '$perm_dir', $seeds_total); catch ME; display(ME.message); end; exit; "
