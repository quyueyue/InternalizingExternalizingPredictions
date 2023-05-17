# Predictive-Feature Matrices (PFM) in HCP analyses

This folder contains functions to compute the predictive-feature matrices for single-KRR model in the HCP analyses

We used an approach from Haufe and colleagues (2014) to transform predictive feature weights associating each FC edge to the behavioral measure. Predictive feature weight was computed by the covariance between the predicted behavioral measure and the FC edge. This resulted in a `87571*1` predictive feature weight vector for each behavioral measure. 

Suppose all data input files are in `$IntExt_DIR/HCP/HCP_data_inputs`, all single-KRR model outputs are in `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/`, and all predictive feature weight outputs go to the same output directory as model outputs,

Run `bash CBIG_TRBPC_PFM_wrapper_HCP.sh -i $IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/ -f $IntExt_DIR/HCP/HCP_data_inputs/features_rs_752.mat -n 18 -o $IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/ -m KRR -c Milgram`
