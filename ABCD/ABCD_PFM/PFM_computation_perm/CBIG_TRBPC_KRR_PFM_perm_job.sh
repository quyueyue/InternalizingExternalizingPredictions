#!/bin/bash

# Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md
model=$1
input_dir=$2
feature_file=$3
outstem=$4
score=$5
perm_start=$6
N_per_job=$7
group=$8
outdir=$9
scripts_dir=`dirname "$(readlink -f "$0")"`

LF=${outdir}/logs/perm_test_score${score}_perm_start${perm_start}.txt
date >> $LF

matlab -nodesktop -nosplash -nodisplay -r " addpath $scripts_dir; \
CBIG_TRBPC_compute_${model}_PFM_perm_stats('${input_dir}','${feature_file}','${outstem}','${score}',${perm_start},\
${N_per_job},'${group}','${outdir}'); exit; " >> $LF
