#!/bin/bash
#SBATCH -J HCP_multiKRR_perm
#SBATCH -t 7-00:00:00
#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --partition psych_week

# for i in {1..18}
# do
#     bash CBIG_MMP_HCP_stats_perm_wrapper.sh "multiKRR" "multiKRR_rs_clinical" /gpfs/milgram/project/holmes/yq222/FYP/HCP/permutations/  /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_output/multiKRR_rs_clinical/ /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_752_subjects.txt /gpfs/milgram/project/holmes/yq222/FYP/HCP/HCP_alldata.csv $i
# done

for i in {1..18}
do
    bash CBIG_MMP_HCP_stats_perm_wrapper.sh "multiKRR" "multiKRR_rs_clinical" $IntExt_DIR/HCP/HCP_perm_output/pred_acc/  $IntExt_DIR/HCP/HCP_output_KRR/multiKRR_rs_clinical/ $IntExt_DIR/HCP/HCP_data_inputs/HCP_752_subjects.txt $IntExt_DIR/HCP/HCP_data_inputs/HCP_alldata.csv $i
done

