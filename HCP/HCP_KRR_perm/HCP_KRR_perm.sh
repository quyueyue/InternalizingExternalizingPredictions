#!/bin/bash
#SBATCH -J HCP_KRR_perm
#SBATCH -t 1-00:00:00
#SBATCH --mem=50G
#SBATCH --partition psych_day

for i in {1..7}
do
    bash CBIG_MMP_HCP_stats_perm_wrapper.sh "singleKRR" "features_rs_423" $IntExt_DIR/HCP/HCP_perm_output/pred_acc/  $IntExt_DIR/HCP/HCP_output_KRR/ $IntExt_DIR/HCP/behavioral_data/HCP_423_subjects.txt $IntExt_DIR/HCP/behavioral_data/HCP_alldata_filtered.csv $i
done
