library(neuroCombat)
library(R.matlab)

## Importing neuroimaging data
HBN_dir='/gpfs/milgram/project/holmes/yq222/FYP/HBN/'
HBN_old_rsfc_list <- readMat(file.path(HBN_dir,'fMRI_data','HBN_old_RSFC.mat'))
HBN_old_rsfc <- HBN_old_rsfc_list$FC.all
HBN_old_sites <- read.delim2(file.path(HBN_dir,'behavioral_data','HBN_old_sites.txt'),header=FALSE)
## Convert HBN_sites.txt to numeric coding
HBN_old_sites_numeric <- numeric(dim(HBN_old_rsfc)[2])
for (i in 1:dim(HBN_old_rsfc)[2]){
  if (HBN_old_sites[i,1]=='SI'){
    HBN_old_sites_numeric[i] <- 1
  }
  else if (HBN_old_sites[i,1]=='RU'){
    HBN_old_sites_numeric[i] <- 2
  }
  else {
    HBN_old_sites_numeric[i] <- 3
  }
}

HBN.old.harmonized <- neuroCombat(dat=HBN_old_rsfc, batch=HBN_old_sites_numeric)
HBN_old_harmonized_data <- HBN.old.harmonized$dat.combat
writeMat(file.path(HBN_dir,'fMRI_data','HBN_old_RSFC_combat.mat'),FC_all=HBN_old_harmonized_data)



