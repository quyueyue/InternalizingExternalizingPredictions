# Compare within- vs between-category correlations in ABCD analyses (multi-KRR model)

This folder contains code used to conduct permutation test whereby the difference between mean correlation within each category (“within-category mean correlation”) and mean correlation with all other three categories (“between-category mean correlation”) was computed 10000 times and used to generate a null distribution of mean differences. 

This analyses focuses on four behavioral categories: Child Internalizing, Child Externalizing, Parent Internalizing and Parent Externalizing.

This function requires an input file named `mean_activation_all_state_df_reordered_int_ext.csv`. This input file contains predictive feature weight vectors (averaged across all cross-validation folds and all brain states) associated with child & parent internalizing and externalizing categories, ordered according to [Child Internalizing, Parent Internalizing, Child Externalizing, Parent Externalizing]. 

To conduct this analysis, run `sbatch compute_PFM_corr_perm_int_ext_multiKRR.sh`
