# PFM significance mask for ABCD analyses

This folder contains code used to generate predictive feature weight significance mask for both single- and multi-kernel models from PFM permutation results stored in `$IntExt_Dir/ABCD/ABCD_perm_output/PFM/KRR/` (single-KRR) and `$IntExt_Dir/ABCD/ABCD_perm_output/PFM/multiKRR/` (multi-KRR).

Suppose that the output directory for the predictive feature weight significance mask is the same as PFM permutation results,

For single-KRR model, run `sbatch compute_PFM_significance_KRR.sh`

For multi-KRR model, run `sbatch compute_PFM_significance_multiKRR.sh`
