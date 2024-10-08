#!/bin/bash
#SBATCH -J prepare_PFM_perm_inputs_KRR
#SBATCH -t 3:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

# feature_file="/gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_subjects_all_task_all_score_rs_bp_sm6.mat"
# input_dir="/gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs_KRR/"
# outdir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/KRR/PFM/"
feature_file=$IntExt_DIR/ABCD/fMRI_data/FC_all.mat
input_dir=$IntExt_DIR/FYP_output/
#outdir=$IntExt_Dir/ABCD/ABCD_perm_output/PFM/multiKRR/
outdir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/multiKRR/PFM/"


########## prepare inputs for the permutation
scripts_dir=`dirname "$(readlink -f "$0")"`

matlab -nodesktop -nosplash -nodisplay -r " addpath $scripts_dir; CBIG_TRBPC_prepare_PFM_perm_inputs_multiKRR( \
   '$feature_file', '$input_dir', '$outdir'); exit; "
