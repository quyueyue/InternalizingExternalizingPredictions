# Analysis pipeline in HBN adults
This directory contains all analysis code needed for:

## HBN_KRR_code
Using 60 random initiations of 10-fold cross-validated kernel ridge regression (KRR) models to predict measures of internalizing and externalizing behavior

## HBN_KRR_perm
Using outputs from HBN_KRR_code to evaluate predictive accuracy of KRR model prediction using permutation testing

## HBN_PFM
### PFM_computation
Using outputs from HBN_KRR_code to compute predictive feature matrices (PFM; a matrix of predictive feature weights) associated with each behavior
### PFM_perm
Using outputs from PFM_computation to carry out permutation testing at the network level to test the statistical significance for each predictive feature weight associated with each behavior
### PFM_significance
Using outputs of PFM_perm, create a significance mask for the PFM associated with each behavior. This significance mask will be used to create Fig.4 (visualizing the statistically significant predictive feature weights associated with total internalizing and externalizing problems in each of the three samples). 

## HBN_exact_test
Using the outputs from PFM_computation, the exact test of differences was conducted between each pair of predictive weight vectors associated with each RSFC edge predicting each pair of behavioral measures across all cross-validation folds.
This test was repeated for all 87,571 RSFC edges and corrected for multiple comparisons using FDR. 
Finally, we determined the proportion of RSFC edges at which the exact test of differences remained statistically significant after FDR for each behavioral comparison. 
