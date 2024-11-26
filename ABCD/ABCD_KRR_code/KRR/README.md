# Kernel Regression Leave-p-Out Cross-Validation workflow

Functions in this folder provides a wrapper function to perform single-kernel leave-p-sites-out cross-validation workflow used in the paper. Suppose all the subjects are from N sites, in each cross-validation fold we choose subjects from p sites as test set and the remaining subjects in the training set. This is repeated N-choose-p times.

`CBIG_TRBPC_KRR_LpOCV_workflow_slurm.sh` is the wrapper function that performs the  single-kernel leave-p-sites-out cross-validation workflow.

Suppose all input files are under the directory `$IntExt_Dir/ABCD/ABCD_data_inputs/`, and all model outputs go to `$IntExt_Dir/ABCD/ABCD_KRR_output/`.

## Inputs

The list of subject IDs for these 5260 subjects is `ICCW_5260_subject_list_unrelated.txt`.

The csv file containing all 5260 subjects' behavioral data and covariates in the same order as specified by `ICCW_5260_subject_list_unrelated.txt` is called `ABCD_5260_alldata.csv`.

The resting-state functional connectivity data for these 5260 subjects in the same order as specified by `ICCW_5260_subject_list_unrelated.txt` is called `ICCW_5260_FC.mat`.

The .txt file containing the column names of the covariates to be entered into the model in `ABCD_5260_alldata.csv` is called `covariates_list.txt`.

## Implementation
To perform single-KRR model prediction, 

1. Run `bash $IntExt_Dir/ABCD/ABCD_KRR_code/KRR/CBIG_TRBPC_KRR_LpOCV_workflow_slurm.sh -csv_file $IntExt_Dir/ABCD/ABCD_data_inputs/ABCD_5260_alldata.csv 
	-subject_list $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_subject_list_unrelated.txt -feature_file $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_FC.mat 
	-y_list $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_ABCD_y_variables.txt -covariate_list $IntExt_Dir/ABCD/ABCD_data_inputs/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score 
	-outdir $IntExt_Dir/ABCD/ABCD_KRR_output/ -stage submitloop`

3. After the first step is finished, run `bash $IntExt_Dir/ABCD/ABCD_KRR_code/KRR/CBIG_TRBPC_KRR_LpOCV_workflow_slurm.sh -csv_file $IntExt_Dir/ABCD/ABCD_data_inputs/ABCD_5260_alldata.csv 
	-subject_list $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_subject_list_unrelated.txt -feature_file $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_5260_FC.mat 
	-y_list $IntExt_Dir/ABCD/ABCD_data_inputs/ICCW_ABCD_y_variables.txt -covariate_list $IntExt_Dir/ABCD/ABCD_data_inputs/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score 
	-outdir $IntExt_Dir/ABCD/ABCD_KRR_output/ -stage gather`

For more information about specific inputs, run `./CBIG_TRBPC_KRR_LpOCV_workflow_slurm.sh --help`.
