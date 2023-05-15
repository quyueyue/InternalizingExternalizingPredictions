#!/bin/sh

outdir=${IntExt_Dir}/ABCD_multiKRR_inputs ## The directory where you want to store FC_all.mat which will be fed as an input to CBIG_TRBPC_multiKRR_LpOCV_workflow_slurm.sh
analysis_type='multiKRR'

matlab -nodesktop -nosplash -nodisplay -r "CBIG_TRBPC_feature_file('$analysis_type','$outdir');exit;"
