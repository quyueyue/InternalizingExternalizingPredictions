# Permutation testing for predictive feature weight in ABCD analyses

Code in this folder conducts permutation testing for the PFM of our single-kernel FC regression model.

We implemented 2000 permutations in total. Suppose that all permuted predictive feature weights (outputs from the PFM permutation function) go to `$IntExt_Dir/ABCD/ABCD_perm_output/PFM/`.

## Inputs
Suppose all predictive feature weight matrices are stored in `$IntExt_Dir/ABCD_KRR_output/` and are used as inputs to PFM permutation function.

All behavioral and neuroimaging data input files are stored in `$IntExt_Dir/ABCD/ABCD_data_inputs/`. The resting-state functional connectivity data for the 5260 ABCD children is stored under this directory as `ICCW_5260_FC.mat`. 

## Implementation
Run `bash CBIG_TRBPC_PFM_perm_wrapper_KRR.sh -i $IntExt_Dir/ABCD/ABCD_KRR_output/ -f $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_FC.mat -n 2000 -t 2000 -g $IntExt_Dir/ABCD/ABCD_data_inputs/site_id_list.txt -o $IntExt_Dir/ABCD/ABCD_perm_output/PFM/ -c Milgram`
