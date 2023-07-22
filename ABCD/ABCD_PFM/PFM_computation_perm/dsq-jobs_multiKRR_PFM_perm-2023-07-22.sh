#!/bin/bash
#SBATCH --array 0-9
#SBATCH --output dsq-jobs_multiKRR_PFM_perm-%A_%1a-%N.out
#SBATCH --job-name dsq-jobs_multiKRR_PFM_perm
#SBATCH --mem-per-cpu=40G --time=7-00:00:00 --partition=psych_week

# DO NOT EDIT LINE BELOW
/gpfs/milgram/apps/hpc.rhel7/software/dSQ/1.05/dSQBatch.py --job-file /gpfs/milgram/pi/holmes/yq222/FYP/ABCD/ABCD_PFM/PFM_computation_perm/jobs_multiKRR_PFM_perm.txt --status-dir /gpfs/milgram/pi/holmes/yq222/FYP/ABCD/ABCD_PFM/PFM_computation_perm

