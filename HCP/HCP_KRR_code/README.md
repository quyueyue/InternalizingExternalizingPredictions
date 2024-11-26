# 60 Random Initiations of 10-fold Cross-Validated Single-Kernel Regression workflow in HCP Analyses

Functions in this folder perform single-kernel ridge regression nested cross validation used in the HCP analyses. 

Suppose that all input files are under the directory `$IntExt_DIR/HCP/behavioral_data/` and `$IntExt_DIR/HCP/fMRI_data/`, and all outputs of the KRR go to `$IntExt_DIR/HCP/HCP_output_KRR/KRR_features_rs_752/` where KRR_features_rs_752 is the outstem,

Run `sbatch CBIG_MMP_HCP_KRR_slurm.sh`
