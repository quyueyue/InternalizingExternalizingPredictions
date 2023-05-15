#!/bin/sh
#SBATCH -J ABCD_multiKRR_prepare_parameters
#SBATCH -t 1:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

root_dir=`dirname "$(readlink -f "$0")"`
csv_file='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/ABCD_alldata.csv'
subject_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/release2_subjects_mf_all_task_all_score_unrelated.txt'
feature_files='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_rs.mat'
y_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/variables_to_predict.txt'
covariate_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/covariates_list.txt'
outstem='all_score'
outdir='/gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs/'
num_leave_out=3
num_inner_folds=10
group_kernel=none
domain=none
metric=predictive_COD
ker_param_file=none
threshold=none
metric='predictive_COD'

matlab -nodesktop -nosplash -nodisplay -r " addpath $root_dir; CBIG_TRBPC_multiKRR_LpOCV_prepare_parameters( \
   '$csv_file', '$subject_list', '$feature_files', '$y_list', '$covariate_list', '$FD_file', \
   '$DVARS_file', '$outdir', '$outstem', '$num_leave_out', '$num_inner_folds','$ker_param_file',\
   '$threshold','$group_kernel','$domain','$metric' );exit; "
