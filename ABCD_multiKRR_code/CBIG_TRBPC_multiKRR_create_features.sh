#!/bin/sh

outdir=/gpfs/milgram/project/holmes/yq222/FYP/ABCD/

matlab -nodesktop -nosplash -nodisplay -r "CBIG_TRBPC_multiKRR_get_inputs('$outdir');exit;"
