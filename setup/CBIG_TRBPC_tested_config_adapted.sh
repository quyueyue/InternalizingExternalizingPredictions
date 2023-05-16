#! /bin/sh
# Last successfully run on July 13, 2021 with git repository version v0.20.0-Kong2022_ArealMSHBM
# Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

# DO NOT CHANGE: This clears old freesurfer variables if they previously exists
if [ -n "$FREESURFER_HOME" ]; then
	$FREESURFER_HOME/bin/clear_fs_env.csh
fi

# PLEASE CHANGE: Please specify location of CBIG repository
export CBIG_CODE_DIR=/gpfs/milgram/project/holmes/yq222/FYP/CBIG/
export IntExt_DIR=/gpfs/milgram/project/holmes/yq222/FYP/
# PLEASE CHANGE: define locations for these libraries
export FREESURFER_HOME=/apps/hpc.rhel7/software/FreeSurfer/5.3.0/
export CBIG_MATLAB_DIR=/apps/hpc.rhel7/software/MATLAB/2018b/
export CBIG_SPM_DIR=/apps/hpc.rhel7/software/SPM/12/
export CBIG_AFNI_DIR=/apps/hpc.rhel7/software/AFNI/2020.1.01/
export CBIG_ANTS_DIR=/apps/hpc.rhel7/software/ANTs/2.3.5-foss-2020b/bin/
export CBIG_WB_DIR=/apps/hpc.rhel7/software/ConnectomeWorkbench/1.4.2/
export CBIG_CARET_DIR=/apps/hpc.rhel7/software/Caret/
export CBIG_FSLDIR=/apps/hpc.rhel7/software/FSL/6.0.4-centos7_64/

# DO NOT CHANGE: define locations for unit tests data and replication data
export CBIG_TESTDATA_DIR=$CBIG_CODE_DIR/stable_projects/predict_phenotypes/ChenTam2022_TRBPC/unit_tests
export CBIG_REPDATA_DIR=$CBIG_CODE_DIR/stable_projects/predict_phenotypes/ChenTam2022_TRBPC/replication

# DO NOT CHANGE: define scheduler location
export CBIG_SCHEDULER_DIR=/apps/sysapps/TORQUE/bin

# DO NOT CHANGE: set up your environment with the configurations above
SETUP_PATH=$CBIG_CODE_DIR/setup/CBIG_generic_setup.sh
source $SETUP_PATH

# DO NOT CHANGE: set up temporary directory for MRIread from FS6.0
export TMPDIR=/gpfs/milgram/project/holmes/yq222/FYP/Thomas_replication/tmpstore

# Do NOT CHANGE: set up MATLABPATH so that MATLAB can find startup.m in our repo
export MATLABPATH=$CBIG_CODE_DIR/setup

# specified the default Python environment.
# Please UNCOMMENT if you follow CBIG's set up for Python environments.
# We use Python version 3.5 as default.
# Please see $CBIG_CODE_DIR/setup/python_env_setup/README.md for more details.
# source activate CBIG_py3
