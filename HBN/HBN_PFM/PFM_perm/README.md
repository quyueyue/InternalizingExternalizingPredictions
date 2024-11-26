# Permutation testing for predictive feature weight in HBN analyses

Code in this folder conducts permutation testing for the PFM of our KRR model in HBN analyses.

We implemented 2000 permutations in total. Suppose that all permuted predictive feature weights (outputs from the PFM permutation function) go to `$IntExt_Dir/HBN/HBN_perm_output/PFM/`.

## Inputs
Suppose all predictive feature weight matrices are stored in `$IntExt_DIR/HBN/HBN_output_KRR/` and are used as inputs to PFM permutation function.

All behavioral and neuroimaging data input files are stored in `$IntExt_DIR/HBN/HBN_data_inputs/`. The resting-state functional connectivity data for the 229 HBN adolescents is stored under this directory as `features_rs_423.mat`. 

The data .csv file containing HBN Subject ID and Family_ID is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_alldata_filtered.csv` and will be an input to the PFM permutation function (to prevent splitting people from the same family across training and testing sets)

The subject IDs of the 229 HBN adolescents used in the analysis is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_229_subjects.txt` and will be used as an input to the PFM permutation function.

## Implementation
Run `sbatch HBN_PFM_perm.sh` or 
run `bash CBIG_TRBPC_PFM_perm_wrapper_HBN.sh -i $IntExt_DIR/HBN/HBN_output_KRR/ -f $IntExt_DIR/HBN/fMRI_data/HBN_RSFC_combat.mat -n 2000 -t 2000 -o $IntExt_Dir/HBN/HBN_perm_output/PFM/ -p $IntExt_DIR/HBN/HBN_data_inputs/HBN_CBCL.csv -l $IntExt_DIR/HBN/HBN_data_inputs/HBN_229_subjects.txt -c Milgram`
