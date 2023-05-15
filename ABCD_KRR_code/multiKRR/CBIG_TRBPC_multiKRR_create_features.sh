#!/bin/sh

outdir=/gpfs/milgram/project/holmes/yq222/FYP/ABCD/
analysis_type='multiKRR'

matlab -nodesktop -nosplash -nodisplay -r "CBIG_TRBPC_feature_file('$analysis_type','$outdir');exit;"
