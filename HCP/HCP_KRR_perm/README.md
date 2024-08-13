# Permutation testing for predictive accuracy in HCP analyses

This folder contains code used to implement permutation testing to assess statistical significance of predictive accuracy for single-KRR model in HCP study.

We implemented 2000 permutations in total. 

Suppose that all input files are under the directory `$IntExt_DIR/HCP/behavioral_data/` and `$IntExt_DIR/HCP/fMRI_data/`, all outputs of the single-KRR are located in `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/`, and all of the permutation results go to `$IntExt_DIR/HCP/HCP_perm_output/pred_acc/`,

1. Run `sbatch HCP_KRR_perm.sh`

2. If you wanna calculate predictive accuracy in terms of correlation: run `compute_HCP_permutation_corr_p_value.sh`; if you wanna calculate in terms of coefficient of determination: run `compute_HCP_permutation_cod_p_value.sh`
