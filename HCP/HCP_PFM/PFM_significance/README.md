# PFM significance mask for HCP analyses

This folder contains code used to generate predictive feature weight significance mask for both single- and multi-kernel models from PFM permutation results stored in `$IntExt_DIR/HCP/HCP_perm_output/PFM/`.

Suppose that the output directory for the predictive feature weight significance mask is the same as PFM permutation results, and all empirical PFM outputs are stored in `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/`,

Run `sbatch compute_PFM_significance_HCP.sh`

