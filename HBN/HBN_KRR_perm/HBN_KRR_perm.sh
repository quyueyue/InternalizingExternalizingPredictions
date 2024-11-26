#!/bin/bash
#SBATCH -J HBN_KRR_perm
#SBATCH -t 1-00:00:00
#SBATCH --mem=50G
#SBATCH --partition psych_day

for i in {1..6}
do
    bash CBIG_MMP_HBN_stats_perm_wrapper.sh "singleKRR" "KRR_HBN" $IntExt_DIR/HBN/HBN_output_KRR/permutations/pred_acc/  $IntExt_DIR/HBN/HBN_output_KRR/ $IntExt_DIR/HBN/HBN_data_inputs/HBN_subjects.txt $IntExt_DIR/HBN/HBN_data_inputs/HBN_CBCL.csv $i
done
