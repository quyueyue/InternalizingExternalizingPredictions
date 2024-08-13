#!/bin/sh

## This script creates FC_all.mat, a 4*1 cell array. The cell array contains the full path of all the four FC feature files that are required to calculate the kernels. 
## Each feature file has a dimension of #FC features x #subjects
## FC_all.mat will be fed as an input to CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh

outdir=${IntExt_DIR}/ABCD/fMRI_data/ ## The directory where you want to store FC_all.mat 
analysis_type='multiKRR'

matlab -nodesktop -nosplash -nodisplay -r "CBIG_TRBPC_create_feature_file('$analysis_type','$outdir');exit;"
