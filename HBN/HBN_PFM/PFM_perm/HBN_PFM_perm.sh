#!/bin/bash
#SBATCH -J HBN_PFM_perm
#SBATCH -t 24:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

bash CBIG_TRBPC_PFM_perm_wrapper_HBN.sh -i $IntExt_DIR/HBN/HBN_output_KRR/ -f $IntExt_DIR/HBN/fMRI_data/HBN_RSFC_combat.mat -n 2000 -t 2000 -o $IntExt_DIR/HBN/HBN_output_KRR/permutations/PFM/ -p $IntExt_DIR/HBN/behavioral_data/HBN_CBCL_old.csv -l $IntExt_DIR/HBN/behavioral_data/HBN_subjects.txt -c Milgram
