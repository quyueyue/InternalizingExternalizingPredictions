# ANALYSIS CODE IN ABCD CHILDREN
This directory contains all analysis code needed for

## ABCD_KRR_code
Using leave-p sites-out cross-validated kernel ridge regression (KRR) models to predict measures of internalizing and externalizing behavior

## ABCD_PFM
### PFM_computation
Using outputs from ABCD_KRR_code to compute predictive feature matrices (PFM; a matrix of predictive feature weights) associated with each behavior
### PFM_perm
Carrying out permutation testing at the network level to test the statistical significance for each predictive feature weight associated with each behavior
### PFM_significance
Based on the outputs of PFM_perm, create a significance mask for the PFM associated with each behavior

## ABCD_exact_test
Using the outputs from PFM_computation to compute, exact test of differences was conducted between each pair of predictive weight vectors associated with each RSFC edge predicting each pair of behavioral measures across all cross-validation folds.
This test was repeated for all 87,571 RSFC edges and corrected for multiple comparisons using FDR. 
Finally, we determined the proportion of RSFC edges at which the exact test of differences remained statistically significant after FDR for each behavioral comparison. 
