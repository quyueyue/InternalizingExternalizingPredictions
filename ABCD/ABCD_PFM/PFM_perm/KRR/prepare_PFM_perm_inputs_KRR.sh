#!/bin/bash
#SBATCH -J prepare_PFM_perm_inputs_KRR
#SBATCH -t 3:00:00
#SBATCH --mem=30G
#SBATCH --partition psych_day

# feature_file="/gpfs/milgram/project/holmes/yq222/FYP/ABCD/FC_subjects_all_task_all_score_rs_bp_sm6.mat"
# input_dir="/gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs_KRR/"
# outdir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/KRR/PFM/"
feature_file=$IntExt_DIR/ABCD/fMRI_data/5260/ICCW_5260_FC.mat
input_dir=$IntExt_DIR/ABCD_output_rs_KRR_5260/
#outdir=$IntExt_DIR/ABCD/ABCD_perm_output/PFM/KRR/
outdir="/gpfs/milgram/project/holmes/yq222/FYP/permutation_5260/KRR/PFM/"


########## prepare inputs for the permutation
scripts_dir=`dirname "$(readlink -f "$0")"`

matlab -nodesktop -nosplash -nodisplay -r " addpath $scripts_dir; CBIG_TRBPC_prepare_PFM_perm_inputs_KRR( \
   '$feature_file', '$input_dir', '$outdir'); exit; "
