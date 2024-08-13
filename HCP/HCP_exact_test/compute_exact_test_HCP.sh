#!/bin/bash
#SBATCH -J exact_test_HCP
#SBATCH -t 1-00:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

module load miniconda
conda activate py3_env
python exact_test_for_comparison_HCP.py
