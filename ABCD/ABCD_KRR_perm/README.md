# Permutation testing for predictive accuracy in ABCD analyses

This folder contains code used to implement permutation testing to assess statistical significance of predictive accuracy for both single- and multi-KRR models. 

For both models, we implemented 2000 permutations in total. The output files are separated into four subsets of 500 permutations each.

Suppose all data input files are under the directory `$IntExt_Dir/ABCD_data_inputs/`, all single- and multi-KRR model outputs are in `$IntExt_Dir/ABCD_multiKRR_output/`, and all permutation results go to `$IntExt_Dir/ABCD_perm_output/pred_acc/KRR/` for single-KRR models and `$IntExt_Dir/ABCD_perm_output/pred_acc/multiKRR/` for multi-KRR models,

To implement permutation testing for single-KRR models, run `bash CBIG_TRBPC_KRR_perm_wrapper.sh -i $IntExt_Dir/ABCD_KRR_output/ -b 33 -s all_score -n 500 -t 2000 -m singleKRR -g $IntExt_Dir/ABCD_data_inputs/site_id_list.txt -o $IntExt_Dir/ABCD_perm_output/pred_acc/KRR/ -c Milgram`

To implement permutation testing for multi-KRR models, run `bash CBIG_TRBPC_KRR_perm_wrapper.sh -i $IntExt_Dir/ABCD_multiKRR_output/ -b 33 -s all_score -n 500 -t 2000 -m multiKRR -g $IntExt_Dir/ABCD_data_inputs/site_id_list.txt -o $IntExt_Dir/ABCD_perm_output/pred_acc/multiKRR/ -c Milgram`
