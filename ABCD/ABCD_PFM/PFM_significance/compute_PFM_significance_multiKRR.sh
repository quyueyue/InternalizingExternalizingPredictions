#!/bin/bash
#SBATCH -J PFM_significance
#SBATCH -t 6:00:00
#SBATCH --mem=20G
#SBATCH --partition psych_day

perm_dir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/multiKRR/PFM/"

scripts_dir=`dirname "$(readlink -f "$0")"`

#perm_dir=$IntExt_Dir/ABCD/ABCD_perm_output/PFM/multiKRR/

outdir=${perm_dir}

matlab -nodesktop -nosplash -nodisplay -r " addpath ${scripts_dir}; CBIG_TRBPC_compute_PFM_significance_mask_multiKRR_wrapper('${perm_dir}','${outdir}'); exit; "
