# Predictive-Feature Matrices (PFM) in ABCD analyses

This folder contains functions to compute the predictive-feature matrices for the KRR model. 

We used an approach from Haufe and colleagues (2014) to transform predictive feature weights associating each FC edge to the behavioral measure. Predictive feature weight was computed by the covariance between the predicted behavioral measure and the FC edge. This resulted in a `87571*1` predictive feature weight vector for each behavioral measure. 

Suppose all data files are stored under the directory `$IntExt_Dir/ABCD/ABCD_data_inputs/`, and all PFM outputs go to `$IntExt_Dir/ABCD/ABCD_KRR_output/` (the same directory as KRR output). 

## Inputs
Since the computation of PFM uses outputs from KRR in `$IntExt_Dir/ABCD/ABCD_KRR_output/`, this directory will be entered as both input and output.

The assignment of subject IDs to training and testing set at each cross-validation fold is stored under `$IntExt_Dir/ABCD/ABCD_KRR_output/` as `no_relative_3_fold_sub_list.mat`. It was automatically generated during KRR implementation.

The resting-state functional connectivity data for these 5260 subjects is called `ICCW_5260_FC.mat` and is stored under the directory `$IntExt_Dir/ABCD/ABCD_data_inputs/`.

## Implementation
To compute predictive feature weight for single-KRR model, run `bash CBIG_TRBPC_PFM_wrapper.sh -i $IntExt_Dir/ABCD/ABCD_KRR_output/ -f $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_FC.mat -s $IntExt_Dir/ABCD/ABCD_data_inputs/no_relative_3_fold_sub_list.mat -n 6 -o $IntExt_Dir/ABCD/ABCD_KRR_output/ -m singleKRR -c Milgram`
