# Predictive-Feature Matrices (PFM) in HCP analyses

This folder contains functions to compute the predictive-feature matrices for single-KRR model in the HCP analyses

We used an approach from Haufe and colleagues (2014) to transform predictive feature weights associating each FC edge to the behavioral measure. Predictive feature weight was computed by the covariance between the predicted behavioral measure and the FC edge. This resulted in a `87571*1` predictive feature weight vector for each behavioral measure. 

Suppose all data input files are in `$IntExt_DIR/HCP/HCP_data_inputs`, and all PFM outputs go to `$IntExt_DIR/HCP/HCP_output_KRR/` (the same output directory as KRR outputs)

## Inputs

Since the computation of PFM uses outputs from KRR in `$IntExt_DIR/HCP/HCP_output_KRR/`, this directory will be entered as both input and output.

The resting-state functional connectivity data for these 423 HCP subjects is called `features_rs_423.mat` and is stored under the directory `$IntExt_Dir/HCP/HCP_data_inputs/`.

## Implementation
To compute predictive feature weight for single-KRR model, run `bash CBIG_TRBPC_PFM_wrapper_HCP.sh -i $IntExt_DIR/HCP/HCP_output_KRR/ -f $IntExt_DIR/HCP/HCP_data_inputs/features_rs_423.mat -n 6 -o $IntExt_DIR/HCP/HCP_output_KRR/ -m KRR -c Milgram`
