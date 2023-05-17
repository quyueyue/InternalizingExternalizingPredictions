# Permutation testing for predictive feature weight in HCP analyses

Code in this folder conducts permutation testing for the PFM of our single-kernel FC regression model in HCP analyses.

We implemented 2000 permutations in total. The output files are separated into two subsets of 1000 permutations each.

Suppose all predictive feature weight matrices are stored in `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/` all behavioral and neuroimaging data input files are stored in `$IntExt_Dir/HCP/HCP_data_inputs/`, and the resulting permuted predictive feature weights go to `$IntExt_Dir/HCP/HCP_perm_output/PFM/`,

Run `bash CBIG_TRBPC_PFM_perm_wrapper_KRR.sh -i $IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/ -f $IntExt_DIR/HCP/HCP_data_inputs/features_rs_752.mat -n 1000 -t 2000 -g $IntExt_DIR/HCP/HCP_data_inputs/site_id_list.txt -o $IntExt_DIR/HCP/HCP_perm_output/PFM/ -c Milgram`
