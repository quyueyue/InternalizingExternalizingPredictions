#!/bin/bash
#SBATCH --array 0-7
#SBATCH --output dsq-jobs_multiKRR_PFM_perm_26-33-%A_%1a-%N.out
#SBATCH --job-name dsq-jobs_multiKRR_PFM_perm_26-33
#SBATCH --cpus-per-task=10 --mem-per-cpu=20G --time=7-00:00:00 --partition=psych_week

# DO NOT EDIT LINE BELOW
/gpfs/milgram/apps/hpc.rhel7/software/dSQ/1.05/dSQBatch.py --job-file /gpfs/milgram/pi/holmes/yq222/FYP/ABCD/ABCD_PFM/PFM_computation_perm/jobs_multiKRR_PFM_perm_26-33.txt --status-dir /gpfs/milgram/pi/holmes/yq222/FYP/ABCD/ABCD_PFM/PFM_computation_perm

