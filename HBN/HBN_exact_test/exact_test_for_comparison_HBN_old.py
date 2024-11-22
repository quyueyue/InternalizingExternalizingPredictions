import warnings
import matplotlib
import matplotlib.pyplot as plt
import sys 
if not sys.warnoptions:
    warnings.simplefilter("ignore")
import numpy as np
import os
import pandas as pd
import scipy.io
import statsmodels
from statsmodels.stats.multitest import fdrcorrection

# Exact test for differences
def get_exact_p(x,y):
    if (np.mean(x-y>=0)<np.mean(x-y<=0)):
        pval = 2*np.mean(x-y>=0)
        dir=-1
    else:
        pval = 2*np.mean(x-y<=0)
        dir=1
    
    return dir,pval

HBN_KRR_PFM_dir='/gpfs/milgram/project/holmes/yq222/FYP/HBN/HBN_old_output_KRR/'

## For each of the 87571 FC edges, out of 120 CV folds, p value = the proportion of feature importance in adult internalizing < or > adult externalizing, whichever with lower proportion
## Higher proportion of larger values in the direction with more higher values, lower p-value


PFM_adult_int=scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score1_all_folds.mat'))['PFM_all_folds']
PFM_adult_anx_dep=scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score2_all_folds.mat'))['PFM_all_folds']
PFM_adult_witd_dep=scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score3_all_folds.mat'))['PFM_all_folds']
PFM_adult_ext=scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score4_all_folds.mat'))['PFM_all_folds']
PFM_adult_rulebreak = scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score5_all_folds.mat'))['PFM_all_folds']
PFM_adult_aggressive = scipy.io.loadmat(os.path.join(HBN_KRR_PFM_dir,'PFM_score6_all_folds.mat'))['PFM_all_folds']

## Record p-values for each comparison
pvals_cv_mean_int_ext=np.zeros((87571,)) 
pvals_cv_mean_anx_witd = np.zeros((87571,))
pvals_cv_mean_anx_ext = np.zeros((87571,))
pvals_cv_mean_witd_ext = np.zeros((87571,))
pvals_cv_mean_within_ext = np.zeros((87571,))
pvals_cv_mean_rulebreak_int = np.zeros((87571,))
pvals_cv_mean_aggressive_int = np.zeros((87571,))

## Record the specific directionality for each comparison
dir_int_ext=np.zeros((87571,)) 
dir_anx_witd = np.zeros((87571,))
dir_anx_ext = np.zeros((87571,))
dir_witd_ext = np.zeros((87571,))
dir_within_ext = np.zeros((87571,))
dir_rulebreak_int = np.zeros((87571,))
dir_aggressive_int = np.zeros((87571,))


for i in range(87571):
    dir_int_ext[i],pvals_cv_mean_int_ext[i]=get_exact_p(PFM_adult_int[i,:],PFM_adult_ext[i,:])
    dir_anx_witd[i],pvals_cv_mean_anx_witd[i]=get_exact_p(PFM_adult_anx_dep[i,:],PFM_adult_witd_dep[i:,])
    dir_anx_ext[i],pvals_cv_mean_anx_ext[i]=get_exact_p(PFM_adult_anx_dep[i,:],PFM_adult_ext[i,:])
    dir_witd_ext[i],pvals_cv_mean_witd_ext[i]=get_exact_p(PFM_adult_witd_dep[i,:],PFM_adult_ext[i,:])
    dir_within_ext[i],pvals_cv_mean_within_ext[i]=get_exact_p(PFM_adult_rulebreak[i,:],PFM_adult_aggressive[i,:])
    dir_rulebreak_int[i],pvals_cv_mean_rulebreak_int[i]=get_exact_p(PFM_adult_rulebreak[i,:],PFM_adult_int[i,:])
    dir_aggressive_int[i],pvals_cv_mean_aggressive_int[i]=get_exact_p(PFM_adult_aggressive[i,:],PFM_adult_int[i,:])

pvals_concatenated = np.concatenate((pvals_cv_mean_int_ext,
                                     pvals_cv_mean_anx_witd,
                                     pvals_cv_mean_anx_ext,pvals_cv_mean_witd_ext, 
                                    pvals_cv_mean_within_ext,pvals_cv_mean_rulebreak_int,pvals_cv_mean_aggressive_int))

exact_test_dir = os.path.join(HBN_KRR_PFM_dir,'exact_test')
if not os.path.exists(exact_test_dir):
    os.makedirs(exact_test_dir)

np.savetxt(os.path.join(exact_test_dir,'pvals_concatenated.csv'),pvals_concatenated)
np.savetxt(os.path.join(exact_test_dir,'dir_int_ext.csv'),dir_int_ext)
qvals_concatenated = fdrcorrection(pvals_concatenated)
qvals_int_ext = qvals_concatenated[1][:87571]
qvals_anx_witd = qvals_concatenated[1][87571:87571*2]
qvals_anx_ext = qvals_concatenated[1][87571*2:87571*3]
qvals_witd_ext = qvals_concatenated[1][87571*3:87571*4]
qvals_within_ext = qvals_concatenated[1][87571*4:87571*5]
qvals_rulebreak_int = qvals_concatenated[1][87571*5:87571*6]
qvals_aggressive_int = qvals_concatenated[1][87571*6:87571*7]

## FDR separately
# qvals_int_ext=fdrcorrection(pvals_cv_mean_int_ext)[1]
# qvals_within_int = fdrcorrection(pvals_cv_mean_within_int)[1]
# qvals_anx_ext = fdrcorrection(pvals_cv_mean_anx_ext)[1]
# qvals_witd_ext = fdrcorrection(pvals_cv_mean_witd_ext)[1]
# qvals_within_ext = fdrcorrection(pvals_cv_mean_within_ext)[1]
# qvals_rulebreak_int = fdrcorrection(pvals_cv_mean_rulebreak_int)[1]
# qvals_aggressive_int = fdrcorrection(pvals_cv_mean_aggressive_int)[1]

prop_sig_diff_int_ext=np.sum(qvals_int_ext<0.05)/87571 ## 34689 out of 87571; 0.3961242877208208/0.33925614644117347 (joint FDR)
prop_sig_diff_anx_witd=np.sum(qvals_anx_witd<0.05)/87571  ## 0.0004567722191136335/0.024768473581436776
prop_sig_diff_anx_ext=np.sum(qvals_anx_ext<0.05)/87571 ## 0.4897968505555492/0.4424409907389433
prop_sig_diff_witd_ext=np.sum(qvals_witd_ext<0.05)/87571 ## 0.13899578627627868/0.13899578627627868
prop_sig_diff_within_ext=np.sum(qvals_within_ext<0.05)/87571 ## 0.17414440853707278/0.17414440853707278
prop_sig_diff_rulebreak_int=np.sum(qvals_rulebreak_int<0.05)/87571 ## 0.3582121935343892/0.3014354066985646
prop_sig_diff_aggressive_int=np.sum(qvals_aggressive_int<0.05)/87571 ## 0.3882678055520663/0.335773258270432

print(f'The proportion between grand internalizing and externalizing is {prop_sig_diff_int_ext}.')
print(f'The proportion between anxious/depressed and withdrawn is {prop_sig_diff_anx_witd}.')
print(f'The proportion between anxious/depressed and grand externalizing is {prop_sig_diff_anx_ext}.')
print(f'The proportion between withdrawn/depressed and grand externalizing is {prop_sig_diff_witd_ext}.')
print(f'The proportion between rulebreaking and aggressive behavior is {prop_sig_diff_within_ext}.')
print(f'The proportion between rulebreaking behavior and grand internalizing is {prop_sig_diff_rulebreak_int}.')
print(f'The proportion between aggressive behavior and grand internalizing is {prop_sig_diff_aggressive_int}.')

## Visualize which edges are significant
sig_edge_bin_int_ext = qvals_concatenated[0][:87571].astype(int)
np.savetxt(os.path.join(HBN_KRR_PFM_dir,'exact_test/sig_edge_bin_int_ext.csv'),sig_edge_bin_int_ext)
## turn 87571*1 vector to 419*419 matrix
num_ROIs = 419
num_nets = 9
## Matrix of binary values indicating significantly different between adult int and ext (or not)
qvals_bin_mat = np.zeros([num_ROIs,num_ROIs])
dir_mat = np.zeros([num_ROIs,num_ROIs])
qvals_bin_mat_prop = np.zeros([num_nets,num_nets])
dir_mat_prop = np.zeros([num_nets,num_nets])

index = -1
for j in range(num_ROIs-1):
    for i in range((j+1),num_ROIs):
        index = index + 1
        qvals_bin_mat[i,j] = sig_edge_bin_int_ext[index]
        dir_mat[i,j]=dir_int_ext[index]
    qvals_bin_mat[i,i] = 0
    dir_mat[i,i]=0

for i in range(num_ROIs):
    for j in range((i+1),num_ROIs):
        qvals_bin_mat[i,j] = qvals_bin_mat[j,i]
        dir_mat[i,j]=dir_mat[j,i]

## rearrange the original 419*419 schaefer ROI order for visualization purposes
vis_lh = np.arange(0,24)
sommot_lh = np.arange(24,59)
dorsatt_lh = np.arange(59,85)
salventatt_lh = np.arange(85,108)
limbic_lh = np.arange(108,120)
cont_lh = np.arange(120,148)
default_lh = np.arange(148,194)
temppar_lh = np.arange(194,200)
vis_rh = np.arange(200,223)
sommot_rh = np.arange(223,258)
dorsatt_rh = np.arange(258,284)
salventatt_rh = np.arange(284,312)
limbic_rh = np.arange(312,324)
cont_rh = np.arange(324,357)
default_rh = np.arange(357,390)
temppar_rh = np.arange(390,400)
subcort = np.arange(400,419)

reorder_idx = np.concatenate((temppar_lh,temppar_rh,default_lh,default_rh,cont_lh,cont_rh,limbic_lh,limbic_rh,
                              salventatt_lh,salventatt_rh,dorsatt_lh,dorsatt_rh,sommot_lh,sommot_rh,vis_lh,vis_rh,subcort))
qvals_bin_mat_reordered=qvals_bin_mat[:,reorder_idx][reorder_idx]
dir_mat_reordered = dir_mat[:,reorder_idx][reorder_idx]

temppar = np.arange(0,16)
dmn = np.arange(16,95)
cont = np.arange(95,156)
lim = np.arange(156,180)
salventatt = np.arange(180,231)
dorsatt = np.arange(231,283)
sommot = np.arange(283,353)
vis = np.arange(353,400)
subcort = np.arange(400,419)

# network_ind=[0,16,29,61,95,107,132,156,169,180,197,231,256,283,314,353,376,400,419]
# network_names = ['temppar','dmnC','dmnB','dmnA','contC','contB','contA','limB','limA','salventattB','salventattA',
#             'dorsattB','dorsattA','sommotB','sommotA','visB','visA','subcort']

network_ind=[0,16,95,156,180,231,283,353,400,419]
network_names = ['temppar','dmn','cont','lim','salventatt',
            'dorsatt','sommot','vis','subcort']

for i in range(len(network_ind)-1):
    for j in range(len(network_ind)-1):
        network_subset_ind_A = slice(network_ind[i],network_ind[i+1])
        network_subset_ind_B = slice(network_ind[j],network_ind[j+1])
        if (i != j):
            edge_ct = (network_ind[i+1]-network_ind[i])*(network_ind[j+1]-network_ind[j])
            #print(f'Network block between {network_names[i]} and {network_names[j]}')
            qvals_bin_mat_prop[i,j]=qvals_bin_mat_reordered[network_subset_ind_A,network_subset_ind_B].sum()/edge_ct
            dir_mat_prop[i,j]=dir_mat_reordered[network_subset_ind_A,network_subset_ind_B].sum()/edge_ct

        else:
            N_edge = network_ind[i+1]-network_ind[i]
            edge_ct = N_edge*(N_edge-1)/2
            qvals_bin_mat_sum=qvals_bin_mat_reordered[np.triu_indices(N_edge, k=1)].sum()
            dir_mat_sum=dir_mat_reordered[np.triu_indices(N_edge, k=1)].sum()
            qvals_bin_mat_prop[i,j]=qvals_bin_mat_sum/edge_ct
            dir_mat_prop[i,j]=dir_mat_sum/edge_ct
            

# mask = np.zeros_like(qvals_bin_mat_prop, dtype=np.bool)
# mask[np.triu_indices_from(mask)] = True

# # Want diagonal elements as well
# mask[np.diag_indices_from(mask)] = False

# # Set up the matplotlib figure
# f, ax = plt.subplots(figsize=(20, 20))

# # Generate a custom diverging colormap
# cmap = sns.color_palette("Blues", as_cmap=True)

# # Draw the heatmap with the mask and correct aspect ratio
# sns_plot = sns.heatmap(qvals_bin_mat_prop, mask=mask, cmap=cmap, vmax=1, center=0.5, vmin=0,
#         square=True, linewidths=.5)
# sns_plot.set_xticks(list(np.arange(9)+0.5))
# sns_plot.set_xticklabels(network_names,fontsize=20,rotation=90)
# sns_plot.set_yticks(list(np.arange(9)+0.5))
# sns_plot.set_yticklabels(network_names,rotation=0,fontsize=20)

# vline_xrange=np.arange(10)
# vline_xrange_add=np.insert(vline_xrange,0,0)
# vline_yrange=(9-vline_xrange_add)/9

# hline_xrange=np.arange(10)+1
# for i in range(10):
#     plt.axvline(x=vline_xrange[i],ymin=0,ymax=vline_yrange[i],color='Black')
#     plt.axhline(y=vline_xrange[i],xmin=0,xmax=hline_xrange[i]/9,color='Black')

# # save to file
# fig = sns_plot.get_figure()
# fig.savefig(os.path.join(HBN_KRR_PFM_dir,'exact_test/HBN_KRR_PFM_diff_int_ext_230913.pdf'))
np.savetxt(os.path.join(HBN_KRR_PFM_dir,'exact_test/HBN_old_qvals_exact_test_int_ext.csv'),qvals_bin_mat_prop)
np.savetxt(os.path.join(HBN_KRR_PFM_dir,'exact_test/HBN_old_dir_exact_test_int_ext.csv'),dir_mat_prop)
