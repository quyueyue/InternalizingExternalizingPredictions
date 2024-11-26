# Distinct brain network features predict internalizing and externalizing traits in children, adolescents and adults

# BACKGROUND
We used resting-state functional connectivity to predict a range of internalizing and externalizing behaviors, in the Adolescent Brain Cognitive Development study (ABCD), Healthy Brain Network (HBN) and Human Connectome Project (HCP) datasets. Across all three samples, behaviors within internalizing and externalizing categories exhibited more similar predictive feature weights than behaviors between categories. These data suggest shared and unique brain network features account for individual variation within broad internalizing and externalizing categories across developmental stages.

# SETUP INSTRUCTIONS
The code pipeline for this project was adapted from Chen, J., Tam, A., Kebets, V. et al. Shared and unique brain network features predict cognitive, personality, and mental health scores in the ABCD study. Nat Commun 13, 2217 (2022). https://doi.org/10.1038/s41467-022-29766-8 (code repo: https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/predict_phenotypes/ChenTam2022_TRBPC) which has a lot of code dependencies from the Computational Brain Imaging Group (CBIG) repository (https://github.com/ThomasYeoLab/CBIG/tree/master). Therefore, we advise you to clone the CBIG repository into your local directory and follow the setup instructions for the CBIG repository. The instructions are available at: https://github.com/ThomasYeoLab/CBIG/blob/master/setup/README.md. Instead of using CBIG/setup/CBIG_sample_config.sh, you need to adapt and use InternalizingExternalizingPredictions/setup/CBIG_TRBPC_tested_config_adapted.sh. 

The `CBIG_CODE_DIR` variable refers to the local directory where the CBIG repository is cloned.

The `IntExt_DIR` variable refers to the local directory where the code for this current repo (InternalizingExternalizingPredictions) is cloned.

Please set them up as separate variables in CBIG_TRBPC_tested_config_adapted.sh. 

# SOFTWARE DEPENDENCIES FOR THIS PROJECT
Freesurfer (5.3.0; https://surfer.nmr.mgh.harvard.edu)

FSL (5.0.8; https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)

MATLAB (2018b; https://www.mathworks.com/products/matlab.html)

Jupyter Notebook 6.4.5 (Python 3.9.7 ipykernel; https://jupyter.org)

Python/3.10.8-GCCcore-12.2.0

neuroCombat (v1.0.13) package in Rv 4.2.0. 
