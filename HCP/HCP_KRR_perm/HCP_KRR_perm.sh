#!/bin/bash
#SBATCH -J HCP_KRR_perm
#SBATCH -t 7-00:00:00
#SBATCH --mem=50G
#SBATCH --partition psych_week

for i in {1..7}
do
    bash CBIG_MMP_HCP_stats_perm_wrapper.sh "singleKRR" "features_rs_752" $IntExt_DIR/HCP/HCP_perm_output/pred_acc/  $IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/ $IntExt_DIR/HCP/behavioral_data/HCP_752_subjects.txt $IntExt_DIR/HCP/behavioral_data/HCP_alldata.csv $i
done
