# Multi-Kernel Regression Leave-p-Out Cross-Validation workfolw

Functions in this folder provides a wrapper function to perform multi-kernel leave-p-sites-out cross-validation workflow used in the paper. Suppose all the subjects are from N sites, in each cross-validation fold we choose subjects from p sites as test set and the remaining subjects in the training set. This is repeated N-choose-p times.

# Usage
`CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh` is the wrapper function that performs the  multi-kernel leave-p-sites-out cross-validation workflow.

To perform multi-KRR model prediction, 

1. Run `bash CBIG_TRBPC_multiKRR_create_features.sh`

2. Run `bash CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh -csv_file /gpfs/milgram/project/holmes/yq222/FYP/ABCD/ABCD_alldata.csv -subject_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/release2_subjects_mf_all_task_all_score_unrelated.txt -feature_files /gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_all.mat -y_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/variables_to_predict.txt -covariate_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score -outdir /gpfs/milgram/project/holmes/yq222/FYP/FYP_output/ -stage submitloop`

3. After the first step is finished, run `bash CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh -csv_file /gpfs/milgram/project/holmes/yq222/FYP/ABCD/ABCD_alldata.csv -subject_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/release2_subjects_mf_all_task_all_score_unrelated.txt -feature_files /gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_all.mat -y_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/variables_to_predict.txt -covariate_list /gpfs/milgram/project/holmes/yq222/FYP/ABCD/covariates_list.txt -FD_file none -DVARS_file none -outstem all_score -outdir /gpfs/milgram/project/holmes/yq222/FYP/FYP_output/ -stage gather`

For more information about specific inputs, run `./CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh --help`.
