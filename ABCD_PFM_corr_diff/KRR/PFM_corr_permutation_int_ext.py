import warnings
import sys 
if not sys.warnoptions:
    warnings.simplefilter("ignore")
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import os
import pandas as pd
import scipy.io

from scipy import stats
import statsmodels
from statsmodels.stats.multitest import fdrcorrection

KRR_output_dir = '/gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs_KRR/'
mean_relevance_all_state_df = pd.read_csv(os.path.join(KRR_output_dir,'mean_activation_all_state_df_reordered_int_ext.csv'),header=None)
n_phenotype = mean_relevance_all_state_df.shape[1]
n_perm = 10000

internalizing_kid = ['cbcl_scr_syn_internal_r',
 'cbcl_scr_syn_anxdep_r',
 'cbcl_scr_syn_withdep_r',
 'cbcl_scr_dsm5_anxdisord_r',
 'cbcl_scr_syn_somatic_r',
 'cbcl_scr_dsm5_somaticpr_r']
internalizing_parent = ['asr_scr_internal_r',
 'asr_scr_anxdep_r',
 'asr_scr_withdrawn_r',
 'asr_scr_depress_r',
 'asr_scr_anxdisord_r',
 'asr_scr_avoidant_r',
 'asr_scr_somatic_r',
 'asr_scr_somaticpr_r']
externalizing_kid = ['cbcl_scr_syn_external_r',
 'cbcl_scr_syn_rulebreak_r',
 'cbcl_scr_syn_aggressive_r',
 'cbcl_scr_dsm5_opposit_r',
 'cbcl_scr_dsm5_conduct_r']
externalizing_parent = ['asr_scr_external_r',
 'asr_scr_rulebreak_r',
 'asr_scr_aggressive_r',
 'asr_scr_antisocial_r']


## Starting indices for each category cluster
cluster_node_start = np.cumsum([0,len(internalizing_kid),len(internalizing_parent),len(externalizing_kid),len(externalizing_parent)])
## How many variables are in each behavioral cluster
cluster_length = np.array([len(internalizing_kid),len(internalizing_parent),len(externalizing_kid),len(externalizing_parent)])

## Create an array holding within and between mean correlation differences at each permutation
meandiff_perm = np.zeros([4,n_perm]) 
brain_corr_all_state = np.corrcoef(mean_relevance_all_state_df, rowvar=False)


for m in range(n_perm):
    ## permute the column order of predictive feature weights for each behavioral measure such that they are not ordered by their pre-assigned categories
    mean_relevance_all_state_df_permuted=mean_relevance_all_state_df.iloc[:,np.random.permutation(np.arange(n_phenotype))]
    ## recompute the correlation between predictive feature weight vectors associated with pairs of behavioral measures after they have been reshuffled
    brain_corr_all_state_permuted=np.corrcoef(mean_relevance_all_state_df_permuted,rowvar=False)
    ## A matrix holding sums of all fisher z-transformed correlation r's within each cluster (diagonal) & between every pair of clusters (off-diagonal)
    within_between_mtx_sum_permuted = np.zeros((4,2))
    ## How many fisher z-transformed correlation r's are there within each cluster (diagonal) & between every pair of clusters (off-diagonal)
    sample_size_within_between = np.zeros((4,2))
    ## A matrix holding means of all fisher z-transformed correlation r's within each cluster (diagonal) & between every pair of clusters (off-diagonal)
    within_between_mtx_mean_permuted = np.zeros((4,2)) 

    ## Within each cluster ..
    for i in range(len(cluster_node_start)-1):
        start_ind = cluster_node_start[i]
        end_ind = cluster_node_start[i+1]
        category_size = end_ind-start_ind
        within_cluster_permuted = brain_corr_all_state_permuted[start_ind:end_ind,start_ind:end_ind] ## hold all correlation r's within a category cluster
        within_cluster_vec_permuted = within_cluster_permuted[np.triu_indices(category_size, k = 1)] ## extract all r's within that cluster (on the lower diagonal since within-category clusters are symmetrical)
        within_between_mtx_sum_permuted[i,0] = np.sum(within_cluster_vec_permuted)
        sample_size_within_between[i,0] = within_cluster_vec_permuted.shape[0] ## number of correlation r's within the cluster - diagonal (i.e. if there are 5 variables within a cluster, then 4+3+2+1=10)
        ## Between the current cluster and every other cluster ..
        for j in range(0,len(cluster_node_start)-1):
            if (j!= i):
                other_cluster_start_ind = cluster_node_start[j]
                other_cluster_end_ind = cluster_node_start[j+1]
                between_cluster = brain_corr_all_state_permuted[start_ind:end_ind,other_cluster_start_ind:other_cluster_end_ind] ## hold all correlation r's between a pair of clusters
                between_cluster_vec = between_cluster.flatten()
                within_between_mtx_sum_permuted[i,1] += np.sum(between_cluster_vec)
                sample_size_within_between[i,1] += between_cluster_vec.shape[0]

    ## Calculate mean correlation for each with- and betw-category block
    for k in range(4): ## 4 categories
        for l in range(2): ## 2 columns
            within_between_mtx_mean_permuted[k,l] = within_between_mtx_sum_permuted[k,l]/sample_size_within_between[k,l]

    meandiff_perm[:,m]=within_between_mtx_mean_permuted[:,0]-within_between_mtx_mean_permuted[:,1]

np.savetxt(os.path.join(KRR_output_dir,"meandiff_perm_int_ext_KRR.csv"), meandiff_perm, delimiter=",")

## Compute the observed mean differences
within_between_mtx_sum = np.zeros((4,2))
for i in range(len(cluster_node_start)-1):
    start_ind = cluster_node_start[i]
    end_ind = cluster_node_start[i+1]
    category_size = end_ind-start_ind
    within_cluster = brain_corr_all_state[start_ind:end_ind,start_ind:end_ind] ## hold all correlation r's within a category cluster
    within_cluster_vec_nozero = within_cluster[np.triu_indices(category_size, k = 1)] ## extract all r's within that cluster (on the lower diagonal since within-category clusters are symmetrical)
    within_between_mtx_sum[i,0] = np.sum(within_cluster_vec_nozero)
    
    for j in range(0,len(cluster_node_start)-1):
        if (j!= i):
            other_cluster_start_ind = cluster_node_start[j]
            other_cluster_end_ind = cluster_node_start[j+1]
            between_cluster = brain_corr_all_state[start_ind:end_ind,other_cluster_start_ind:other_cluster_end_ind] ## hold all correlation r's between a pair of clusters
            between_cluster_vec = between_cluster.flatten()
            within_between_mtx_sum[i,1] += np.sum(between_cluster_vec)

within_betw_mean = np.zeros([4,2])

for i in range(4):
    for j in range(2):
        within_betw_mean[i,j] = within_between_mtx_sum[i,j]/sample_size_within_between[i,j]

meandiff_observed = within_betw_mean[:,0] - within_betw_mean[:,1]
np.savetxt(os.path.join(KRR_output_dir,"meandiff_observed_int_ext_KRR.csv"), meandiff_observed, delimiter=",")

p_perm = np.zeros([4,])
for i in range(4):
    p_perm[i] = np.sum(permuted_meandiff > meandiff_observed[i] for permuted_meandiff in meandiff_perm[i,:])/n_perm

q_perm = fdrcorrection(p_perm)
print(q_perm)