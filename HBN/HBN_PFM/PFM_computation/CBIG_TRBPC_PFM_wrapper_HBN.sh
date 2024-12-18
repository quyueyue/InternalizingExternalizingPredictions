#!/bin/bash

# Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

###########################################
# Usage and Reading in Parameters
###########################################

# Usage
usage() { echo "
Usage: $0 -i <input_dir> -f <feature_file> -n <num_score> -o <outdir> -m <model> [-c <cluster>]
    This function computes the predictive-feature matrices for a regression model
    - input_dir     Directory where the regression results are stored
    - feature_file  Full path of the regression feature file
    - num_score     Number of behavioral scores to compute the PFM
    - outdir        Output directory
    - model         regression model. Choose from singleKRR, multiKRR, and LRR
    - cluster       (Optional) if you do not have a cluster, put it as "none", then the computation will
		    run serially (potentially very slow!) for each behavior. If you have a cluster, put
		    your cluster name and the function submit parallel jobs to your cluster
" 1>&2; exit 1; }

# Reading in parameters
while getopts ":i:f:n:o:m:c:" opt; do
    case "${opt}" in
        i) input_dir=${OPTARG};;
        f) feature_file=${OPTARG};;
        n) num_score=${OPTARG};;
        o) outdir=${OPTARG};;
        m) model=${OPTARG};;
        c) cluster=${OPTARG};;
        *) usage;;
    esac
done
shift $((OPTIND-1))
if [ -z "${input_dir}" ] || [ -z "${feature_file}" ] || \
     [ -z "${num_score}" ] || [ -z "${model}" ] || [ -z "${outdir}" ] ; then
    echo Missing Parameters!
    usage
fi

###########################################
# Main
###########################################

mkdir -p $outdir/job_err_out
mkdir -p $outdir/logs
LF="$outdir/logs/compute_${model}_PFM.log"
date >> $LF

########## compute the PFM

scripts_dir=`dirname "$(readlink -f "$0")"`

for score_ind in `seq 1 $num_score`
do
    echo $score_ind

    if [ "$cluster" == "none" ];then

        ${scripts_dir}/CBIG_TRBPC_PFM_job.sh $input_dir $feature_file $score_ind $outdir $model

    else
        outfile=${outdir}/job_err_out/${model}_PFM_score${score_ind}.out
        sbatch --job-name=${testLPname} --partition=psych_day --time=20:00:00 --mem-per-cpu=100G --wrap="${scripts_dir}/CBIG_TRBPC_PFM_job_HBN.sh $input_dir $feature_file $score_ind $outdir $model"
    fi
done
