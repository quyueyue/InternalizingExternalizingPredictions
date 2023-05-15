#!/bin/bash
#SBATCH -J compute_PFM_corr_perm_int_ext
#SBATCH -t 3:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

module load miniconda
conda activate py3_env
python PFM_corr_permutation_int_ext.py
