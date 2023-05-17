# Multi-Kernel Regression Leave-p-Out Cross-Validation workfolw

Functions in this folder provides a wrapper function to perform multi-kernel leave-p-sites-out cross-validation workflow used in the paper. Suppose all the subjects are from N sites, in each cross-validation fold we choose subjects from p sites as test set and the remaining subjects in the training set. This is repeated N-choose-p times.

# Usage
`CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh` is the wrapper function that performs the  multi-kernel leave-p-sites-out cross-validation workflow.

Suppose all input files are under the directory `$IntExt_Dir/ABCD/ABCD_data_inputs/`, and all model outputs go to `$IntExt_Dir/ABCD/ABCD_multiKRR_output/`,

To perform multi-KRR model prediction, 

1. Run `bash CBIG_TRBPC_multiKRR_create_features.sh`

2. Run `bash $IntExt_Dir/ABCD/ABCD_KRR_code/multiKRR/CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh -csv_file $IntExt_Dir/ABCD/ABCD_data_inputs/ABCD_alldata.csv 
	-subject_list $IntExt_Dir/ABCD/ABCD_data_inputs/release2_subjects_mf_all_task_all_score_unrelated.txt -feature_files $IntExt_Dir/ABCD/ABCD_data_inputs/FC_all.mat 
	-y_list $IntExt_Dir/ABCD/ABCD_data_inputs/variables_to_predict.txt -covariate_list $IntExt_Dir/ABCD/ABCD_data_inputs/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score 
	-outdir $IntExt_Dir/ABCD/ABCD_multiKRR_output/ -stage submitloop`

3. After the first step is finished, run `bash $IntExt_Dir/ABCD/ABCD_KRR_code/multiKRR/CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh -csv_file $IntExt_Dir/ABCD/ABCD_data_inputs/ABCD_alldata.csv 
	-subject_list $IntExt_Dir/ABCD/ABCD_data_inputs/release2_subjects_mf_all_task_all_score_unrelated.txt -feature_files $IntExt_Dir/ABCD/ABCD_data_inputs/FC_all.mat 
	-y_list $IntExt_Dir/ABCD/ABCD_data_inputs/variables_to_predict.txt -covariate_list $IntExt_Dir/ABCD/ABCD_data_inputs/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score 
	-outdir $IntExt_Dir/ABCD/ABCD_multiKRR_output/ -stage gather`

For more information about specific inputs, run `./CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh --help`.
