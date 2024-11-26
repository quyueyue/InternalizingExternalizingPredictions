#!/bin/bash
#SBATCH -J PFM_significance
#SBATCH -t 2:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

## CHANGE THIS
perm_dir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_5260/KRR/PFM/"
## CHANGE THIS; ASSUMING THAT THE SIGNIFICANCE MASK GOES TO THE SAME DIRECTORY AS THE PFM PERMUTATION RESULTS
outdir=${perm_dir}
scripts_dir=`dirname "$(readlink -f "$0")"`

matlab -nodesktop -nosplash -nodisplay -r " addpath ${scripts_dir}; CBIG_TRBPC_compute_PFM_significance_mask_KRR_wrapper('${perm_dir}','${outdir}'); exit; "
