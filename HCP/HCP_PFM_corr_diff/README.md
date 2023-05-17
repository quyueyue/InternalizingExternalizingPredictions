# Compare within- vs between-category correlations in HCP analyses (single-KRR model)

This folder contains code used to conduct permutation test whereby the difference between mean correlation within each category (“within-category mean correlation”) and mean correlation with all other three categories (“between-category mean correlation”) was computed 10000 times and used to generate a null distribution of mean differences. 

This analyses focuses on four behavioral categories: Child Internalizing, Adult Internalizing, Child Externalizing and Adult Externalizing.

This function requires an input file named `HCP_mean_activation_all_state_df_reordered_int_ext.csv`. This input file contains predictive feature weight vectors (averaged across all cross-validation folds) associated with child & adult internalizing and externalizing categories, ordered according to [Child Internalizing, Adult Internalizing, Child Externalizing, Adult Externalizing]. 

To conduct this analysis, run `sbatch compute_PFM_corr_perm_int_ext_KRR.sh`
