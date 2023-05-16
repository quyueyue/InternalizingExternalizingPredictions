# Permutation testing for predictive feature weight in ABCD analyses

This folder computes the significance mask for the PFM of our multi-kernel FC regression model.

We implemented 2000 permutations in total. The output files are separated into two subsets of 1000 permutations each.

Suppose all predictive feature weight matrices are stored in `$IntExt_Dir/ABCD_multiKRR_output/` all behavioral and neuroimaging data input files are stored in `$IntExt_Dir/ABCD_data_inputs/`, and the resulting predictive feature weights go to `$IntExt_Dir/ABCD_perm_output/PFM/multiKRR/`,


1. Run `sbatch prepare_PFM_perm_inputs_KRR.sh`

2. Run `bash CBIG_TRBPC_PFM_perm_wrapper.sh -i $IntExt_Dir/ABCD_KRR_output/ -f $IntExt_Dir/ABCD_data_inputs/FC_subjects_all_task_all_score_rs_bp_sm6.mat -n 1000 -t 2000 -g $IntExt_Dir/ABCD_data_inputs/site_id_list.txt -o $IntExt_Dir/ABCD_perm_output/PFM/multiKRR/ -c Milgram`