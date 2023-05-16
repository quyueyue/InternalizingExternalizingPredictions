# Compare within- vs between-category correlations in ABCD analyses (single-KRR model)

This folder contains code used to conduct permutation test whereby the difference between mean correlation within each category (“within-category mean correlation”) and mean correlation with all other three categories (“between-category mean correlation”) was computed 10000 times and used to generate a null distribution of mean differences. This analyses focuses on four behavioral categories: Child Internalizing, Child Externalizing, Parent Internalizing and Parent Externalizing.

To conduct this analysis, run `sbatch compute_PFM_corr_perm_int_ext.sh`
