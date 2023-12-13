#!/bin/sh
#SBATCH -J ABCD_multiKRR_prepare_parameters
#SBATCH -t 1:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

root_dir=`dirname "$(readlink -f "$0")"`
csv_file='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/behavioral_data/ABCD_alldata.csv'
subject_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/behavioral_data/release2_subjects_mf_all_task_all_score_unrelated.txt'
feature_file='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/fMRI_data/FC_all.mat'
y_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/behavioral_data/variables_to_predict.txt'
covariate_list='/gpfs/milgram/project/holmes/yq222/FYP/ABCD/behavioral_data/covariates_list.txt'
outstem='all_score'
group_kernel=none
domain=none
outdir='/gpfs/milgram/project/holmes/yq222/FYP/FYP_output/'
num_leave_out=3
num_inner_folds=10
metric=predictive_COD
culster=Milgram
# Set default value for other parameters. They are not input arguments as they are very unlikely to be changed, but you
# can still change it here if you want to:
ker_param_file=none
threshold_set_file=none

matlab -nodesktop -nosplash -nodisplay -r " addpath $root_dir; CBIG_TRBPC_multiKRR_LpOCV_prepare_parameters( '$csv_file',\
    '$subject_list', '$feature_file', '$y_list', '$covariate_list', '$FD_file', '$DVARS_file', '$outdir', '$outstem', \
    '$num_leave_out','$num_inner_folds', '$ker_param_file','$threshold_set_file','$group_kernel',\
    '$domain','$metric' ); exit; "
