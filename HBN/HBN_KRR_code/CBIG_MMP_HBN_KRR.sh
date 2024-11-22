#!/bin/sh
#####
# This script calls the matlab function to run KRR. User needs to provide the following variables.
# 1. feature_path: path to feature mat file
# 2. outdir: output directory
# 3. outerFolds: number of outer folds
# 4. innerFold: number of inner folds
# 5. subtxt: list of subjects
# 6. scorecsv: table of behaviour scores and gender
# 7. restrictedcsv: table of family ID and age
# 8. predvar: txt file of names of behaviours to predict from subcsv
# 9. covtxt: txt file of names of covariates to regress from y variables
# 10. ymat: output name of behaviours to be predicted
# 11. covmat: output name of covariates to control for
# 12. split_idx: current split
# 
# EXAMPLE: 
#	CBIG_MMP_HCP_KRR.sh $feature_path $outdir $outerFolds $innerFolds $subtxt $scorecsv \
#		$restrictedcsv $predvar $covtxt $ymat $covmat $split_idx
# EXAMPLE OF HOW TO CALL FUNCTION:
# 	CBIG_MMP_HCP_KRR.sh data_dir/features/rs.mat output_dir 10 10 data_dir/subs.txt \
#		data_dir/scores.csv data_dir/HCP_restricted.csv data_dir/prediction_variables.txt \
#		data_dir/covariates.txt "output_y.mat" "output_cov.mat" 1	
# Written by Leon Ooi and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

# set directories
script_dir=$(dirname "$(readlink -f "$0")")

# set outstem
feature_path=$1
#featurebase=$(basename $feature_path)
outstem="KRR_HBN"

# set params
outdir=$2
outerFolds=$3
innerFolds=$4
subtxt=$5
scorecsv=$6
#restrictedcsv=$7
predvar=$7
covtxt=$8
ymat=${9}
covmat=${10}
split_idx=${11}

# Create log file and save params
mkdir -p $outdir/logs
LF="$outdir/logs/${outstem}_${split_idx}.log"
if [ -f $LF ]; then rm $LF; fi
echo "outstem = $outstem" >> $LF
echo "outdir = $outdir" >> $LF
echo "outerFolds = $outerFolds" >> $LF
echo "innerFolds = $innerFolds" >> $LF
echo "subtxt = $subtxt" >> $LF
echo "scorecsv = $scorecsv" >> $LF
#echo "restrictedcsv = $restrictedcsv" >> $LF
echo "predvar = $predvar" >> $LF
echo "covtxt = $covtxt" >> $LF
echo "ymat = $ymat" >> $LF
echo "covmat = $covmat" >> $LF
echo "split_idx = $split_idx" >> $LF

# Call matlab function
matlab -nodesktop -nosplash -nodisplay -r " try addpath('$script_dir'); CBIG_MMP_HBN_KRR( \
   $outerFolds,$innerFolds,'$feature_path',$split_idx,'$outdir','$subtxt','$scorecsv', \
   '$predvar','$covtxt','$ymat','$covmat'); catch ME; display(ME.message); \
   end; exit; " >> $LF 2>&1
