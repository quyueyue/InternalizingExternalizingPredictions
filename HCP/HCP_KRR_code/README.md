# Single-Kernel Regression Leave-p-Out Cross-Validation workflow in ABCD Study


Functions in this folder perform single-kernel ridge regression nested cross validation used in the HCP analyses. 

Suppose that all input files are under the directory `$IntExt_DIR/HCP/HCP_data_inputs/` and all outputs of the single-KRR go to `$IntExt_DIR/HCP/HCP_output_KRR`,

Run `sbatch CBIG_MMP_HCP_KRR_slurm.sh`
