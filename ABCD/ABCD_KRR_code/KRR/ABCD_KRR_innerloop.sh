#!/bin/sh
#SBATCH -J ABCD_KRR_innerloop
#SBATCH -t 5:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=20
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
cluster=Milgram
# Set default value for other parameters. They are not input arguments as they are very unlikely to be changed, but you
# can still change it here if you want to:
ker_param_file=none
threshold_set_file=none

paramfile=${outdir}/param.mat
num_test_folds=`cat ${outdir}/num_test_folds.txt`
for test_fold in `seq 1 ${num_test_folds}`
do
    cmd="${root_dir}/CBIG_TRBPC_KRR_LpOCV_innerloop.sh -p ${paramfile} -t ${test_fold} -o ${outdir}"
#            errfile=${outdir}/job_err_out/innerloop_${test_fold}.err
    outfile=${outdir}/job_err_out/innerloop_${test_fold}.out
    sbatch --job-name=${innerLPname} --partition=psych_day --time=2:00:00 --mem-per-cpu=8G --wrap="${root_dir}/CBIG_TRBPC_KRR_LpOCV_innerloop.sh -p ${paramfile} -t ${test_fold} -o ${outdir}"
done
