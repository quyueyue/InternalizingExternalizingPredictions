#!/bin/bash
#SBATCH -J compute_HCP_PFM_corr_perm
#SBATCH -t 3:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

module load miniconda
conda activate py3_env
python HCP_PFM_corr_permutation.py
