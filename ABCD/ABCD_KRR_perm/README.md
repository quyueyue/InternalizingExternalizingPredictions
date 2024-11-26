# Permutation testing for predictive accuracy in ABCD analyses

This folder contains code used to implement permutation testing to assess statistical significance of predictive accuracy for both single- and multi-KRR models. 

We implemented 2000 permutation rounds in total. 

Suppose all data input files are under the directory `$IntExt_Dir/ABCD/ABCD_data_inputs/`, all KRR model outputs are in `$IntExt_Dir/ABCD/ABCD_KRR_output/`, and all permutation results go to `$IntExt_Dir/ABCD/ABCD_perm_output/pred_acc/`

## Inputs
Since permutation testing is conducted on outputs from KRR, the KRR model output directory `$IntExt_Dir/ABCD/ABCD_KRR_output/` is entered as the input directory to the permutation function.

The permutation testing was conducted such that subjects within the same sites were never split across training and testing set in the same cross-validation fold. As such, the site information for each subject was also entered as an input. Supposed that the site number for each subject is stored under `$IntExt_Dir/ABCD/ABCD_data_inputs/` as `site_id_list.txt`.

## Implementation
To implement permutation testing for single-KRR models, run `bash CBIG_TRBPC_KRR_perm_wrapper.sh -i $IntExt_Dir/ABCD/ABCD_KRR_output/ -b 6 -s all_score -n 2000 -t 2000 -m singleKRR -g $IntExt_Dir/ABCD/ABCD_data_inputs/site_id_list.txt -o $IntExt_Dir/ABCD/ABCD_perm_output/pred_acc/ -c Milgram`
