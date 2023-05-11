#!/bin/bash
#SBATCH --array 0-131
#SBATCH --output dsq-jobs-%A_%3a-%N.out
#SBATCH --job-name multiKRR_PFM
#SBATCH --mem-per-cpu=16G --time=12:00:00 --partition=psych_day

# DO NOT EDIT LINE BELOW
/gpfs/milgram/apps/hpc.rhel7/software/dSQ/1.05/dSQBatch.py --job-file /gpfs/milgram/pi/holmes/yq222/FYP/jobs.txt --status-dir /gpfs/milgram/pi/holmes/yq222/FYP

