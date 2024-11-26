# Permutation testing for predictive accuracy in HBN analyses

This folder contains code used to implement permutation testing to assess statistical significance of predictive accuracy for KRR model in HBN study.

We implemented 2000 permutations in total. 

Suppose that all input files are under the directory `$IntExt_DIR/HBN/HBN_data_inputs/`, all KRR outputs of are located in `$IntExt_DIR/HBN/HBN_output_KRR/`, and all of the permutation results go to `$IntExt_DIR/HBN/HBN_perm_output/pred_acc/`,

## Inputs
Since permutation testing is conducted on outputs from KRR, the KRR model output directory `$IntExt_Dir/HBN/HBN_KRR_output/` is entered as the input directory to the permutation function.

The data .csv file containing HBN Subject ID, site name and behavioral variables is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_CBCL.csv` and will be an input to the KRR permutation function (to prevent splitting people from the same site across training and testing sets)

The subject IDs of the 229 HBN adults used in the analysis is stored under `$IntExt_DIR/HBN/HBN_data_inputs/` as `HBN_229_subjects.txt` and will be used as an input to the KRR permutation function.

## Implementation

1. Run `sbatch HBN_KRR_perm.sh`

2. If you wanna calculate predictive accuracy in terms of Pearson's correlation: run `compute_HBN_permutation_corr_p_value.sh`; if you wanna calculate in terms of coefficient of determination: run `compute_HBN_permutation_cod_p_value.sh`











