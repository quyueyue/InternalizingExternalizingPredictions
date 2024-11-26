# Permutation testing for predictive feature weight in HCP analyses

Code in this folder conducts permutation testing for the PFM of our single-kernel FC regression model in HCP analyses.

We implemented 2000 permutations in total. Suppose that all permuted predictive feature weights (outputs from the PFM permutation function) go to `$IntExt_Dir/HCP/HCP_perm_output/PFM/`.

## Inputs
Suppose all predictive feature weight matrices are stored in `$IntExt_DIR/HCP/HCP_output_KRR/` and are used as inputs to PFM permutation function.

All behavioral and neuroimaging data input files are stored in `$IntExt_DIR/HCP/HCP_data_inputs/`. The resting-state functional connectivity data for the 423 HCP adults is stored under this directory as `features_rs_423.mat`. 

## Implementation
Run `sbatch HCP_PFM_perm.sh`
