#!/bin/bash

data_dir="/gpfs/milgram/data/HCP/FMRI_PREPROCESSED"
HCP_dir="/gpfs/milgram/project/holmes/yq222/FYP/HCP"

for subj_dir in $data_dir/*/
do
    subid=$(basename "$subj_dir")
    echo "$subid" >> ${HCP_dir}/HCP_1200_FD.csv
    num_avail=0
    sum_FD=0
    declare -a rest_filenames=( "rest1LR" "rest1RL" "rest2LR" "rest2RL" )
    for filename in "${rest_filenames[@]}"
    do
        FD_path=${subj_dir}${filename}/Movement_RelativeRMS_mean.txt
        #echo $FD_path
        if [[ -f "$FD_path" ]]; then
            FD_value=$(cat $FD_path)
            num_avail=$((num_avail + 1))
            sum_FD=`echo "scale=20; $sum_FD + $FD_value" | bc`
        fi
    done
    if (( $num_avail != 0 ))
    then
        meanFD=`echo "scale=20; $sum_FD / $num_avail" | bc`
        echo "${meanFD}" >> ${HCP_dir}/HCP_1200_FD.csv
    else
        echo 999 >> ${HCP_dir}/HCP_1200_FD.csv
    fi
    echo "subject ${subid} completed"
done
