#!/bin/bash

# Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

FC_mean_file=$1
y_file=$2
krr_folds=$3
perm_seed_start=$4
perm_num=$5
outdir=$6
family_list=$7
subject_list=$8
seed_idx=$9

scripts_dir=`dirname "$(readlink -f "$0")"`

seed="seed_"${seed_idx}
LF=${outdir}/${seed}/logs/PFM_perm_start_${perm_seed_start}.txt
date >> $LF
matlab -nodesktop -nosplash -nodisplay -r " addpath $scripts_dir; CBIG_TRBPC_compute_PFM_permutation_stats_HCP( \
'$FC_mean_file','$y_file','$krr_folds','$perm_seed_start','$perm_num','$family_list','$subject_list','$outdir','$seed_idx'); \
exit; " >> $LF
