# Permutation testing for predictive feature weight in HCP analyses

Code in this folder conducts permutation testing for the PFM of our single-kernel FC regression model in HCP analyses.

We implemented 2000 permutations in total. Suppose that all permuted predictive feature weights (outputs from the PFM permutation function) go to `$IntExt_Dir/HCP/HCP_perm_output/PFM/`.

## Inputs
Suppose all predictive feature weight matrices are stored in `$IntExt_DIR/HCP/HCP_output_KRR/` and are used as inputs to PFM permutation function.

All behavioral and neuroimaging data input files are stored in `$IntExt_DIR/HCP/HCP_data_inputs/`. The resting-state functional connectivity data for the 423 HCP adults is stored under this directory as `features_rs_423.mat`. 

The data .csv file containing HCP Subject ID and Family_ID is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `HCP_alldata_filtered.csv` and will be an input to the PFM permutation function (to prevent splitting people from the same family across training and testing sets)

The subject IDs of the 423 HCP adults used in the analysis is stored under `$IntExt_DIR/HCP/HCP_data_inputs/` as `HCP_423_subjects.txt` and will be used as an input to the PFM permutation function.

## Implementation
Run `sbatch HCP_PFM_perm.sh` or 
run `bash CBIG_TRBPC_PFM_perm_wrapper_HCP.sh -i $IntExt_DIR/HCP/HCP_output_KRR/ -f $IntExt_DIR/HCP/HCP_data_inputs/features_rs_423.mat -n 2000 -t 2000 -o $IntExt_DIR/HCP/HCP_perm_output/PFM/ -p $IntExt_DIR/HCP/behavioral_data/HCP_alldata_filtered.csv -l $IntExt_DIR/HCP/behavioral_data/HCP_423_subjects.txt -c Milgram`
