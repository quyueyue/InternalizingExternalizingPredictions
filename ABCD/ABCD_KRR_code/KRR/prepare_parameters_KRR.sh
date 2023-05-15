#!/bin/sh
#SBATCH -J ABCD_KRR_prepare_parameters
#SBATCH -t 1:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

root_dir=`dirname "$(readlink -f "$0")"`
csv_file='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/ABCD_alldata.csv'
subject_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/release2_subjects_mf_all_task_all_score_unrelated.txt'
feature_file='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_subjects_all_task_all_score_rs_bp_sm6.mat'
y_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/variables_to_predict.txt'
covariate_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/covariates_list.txt'
outstem='all_score'
outdir='/gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs_KRR/'
num_leave_out=3
num_inner_folds=10
lambda_set_file=none
metric=predictive_COD
culster=Milgram
# Set default value for other parameters. They are not input arguments as they are very unlikely to be changed, but you
# can still change it here if you want to:
ker_param_file=none
threshold_set_file=none

matlab -nodesktop -nosplash -nodisplay -r " addpath $root_dir; CBIG_TRBPC_KRR_LpOCV_prepare_parameters( '$csv_file',\
    '$subject_list', '$feature_file', '$y_list', '$covariate_list', '$FD_file', '$DVARS_file', '$outdir', '$outstem', \
    '$num_leave_out','$num_inner_folds', '$ker_param_file','$lambda_set_file','$threshold_set_file',\
    '$metric' ); exit; "