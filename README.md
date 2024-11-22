# Distinct brain network features predict internalizing and externalizing traits in children, adolescents and adults

# BACKGROUND
We used resting-state functional connectivity to predict a range of internalizing and externalizing behaviors, in the Adolescent Brain Cognitive Development study (ABCD), Healthy Brain Network (HBN) and Human Connectome Project (HCP) datasets. Across all three samples, behaviors within internalizing and externalizing categories exhibited more similar predictive feature weights than behaviors between categories. These data suggest shared and unique brain network features account for individual variation within broad internalizing and externalizing categories across developmental stages.

# PREREQUISITE

Please follow the instructions carefully to set up the CBIG environment in your local environment. The instructions are available at : https://github.com/ThomasYeoLab/CBIG/blob/master/setup/README.md

# USAGE
## Setup
1. Make sure you have installed: Matlab 2018b
2. Follow $CBIG_CODE_DIR/setup/README.md to setup the CBIG repository config file.
3. Instead of using CBIG/setup/CBIG_sample_config.sh, you need to use InternalizingExternalizingPredictions/setup/CBIG_TRBPC_tested_config_adapted.sh.

## Regression models
* `KRR_LpOCV` (Kernel Ridge Regression Leave-p-Out Cross Validation): this folder contains leave-p-out cross validation workflow for both multi-kernel ridge regression and single-kernel ridge regression.
* `LRR_LpOCV` (Linear Ridge Regression Leave-p-Out Cross Validation): this folder contains leave-p-out cross validation workflow for linear ridge regression.
## Interpret the regression models
* This depends on the results from regression models
* `PFM` (Predictive-Feature Matrix): this folder contains functions to compute the predictive-feature matrix for both kernel ridge regression and linear ridge regression.
## Permutation test for significance
* This depends on the results from the regression models
* `permutation` this folder contains functions for the permutation test of kernel regression and predictive feature matrix
