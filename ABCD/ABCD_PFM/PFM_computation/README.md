# Predictive-Feature Matrices (PFM) in ABCD analyses

This folder contains functions to compute the predictive-feature matrices for both single- and multi-KRR models. 

We used an approach from Haufe and colleagues (2014) to transform predictive feature weights associating each FC edge to the behavioral measure. Predictive feature weight was computed by the covariance between the predicted behavioral measure and the FC edge. This resulted in a `87571*1` predictive feature weight vector for each of the four brain states (for multi-KRR) and each behavioral measure. 

Suppose all data input files are in `$IntExt_Dir/ABCD_data_inputs/`, all single- and multi-KRR model outputs are in `$IntExt_Dir/ABCD_KRR_output/` and `$IntExt_Dir/ABCD_multiKRR_output/` respectively, and all predictive feature weight outputs go to the same output directory as model outputs,

To compute predictive feature weight for single-KRR model, run `bash CBIG_TRBPC_PFM_wrapper.sh -i $IntExt_Dir/ABCD_KRR_output/ -f $IntExt_Dir/ABCD_data_inputs/FC_subjects_all_task_all_score_rs_bp_sm6.mat -s $IntExt_Dir/ABCD_data_inputs/release2_subjects_mf_all_task_all_score_unrelated.txt -n 33 -o $IntExt_Dir/ABCD_KRR_output/ -m singleKRR -c Milgram`

To compute predictive feature weight for multi-KRR model, run `bash CBIG_TRBPC_PFM_wrapper.sh -i $IntExt_Dir/ABCD_multiKRR_output/ -f $IntExt_Dir/ABCD_data_inputs/FC_all.mat -s $IntExt_Dir/ABCD_data_inputs/release2_subjects_mf_all_task_all_score_unrelated.txt -n 33 -o $IntExt_Dir/ABCD_multiKRR_output/ -m multiKRR -c Milgram`
