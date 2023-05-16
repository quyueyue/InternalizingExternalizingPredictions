function hyp_driven_mask = CBIG_TRBPC_compute_PFM_significance_mask_KRR_wrapper(perm_dir, outdir)

% PFM_network = [data_driven_mask, hyp_driven_mask] = CBIG_TRBPC_compute_PFM_significance_mask_wrapper(outdir)
%
% This function computes the significance mask of the multiKRR PFM of each behavioral
% cluster and each brain state. We used both data-driven behavioral culsters and 
% hypothesis-driven behavioral culsters
%
% Inputs:
%   - perm_dir
%     Directory storing the permutation results of the predictive feature matrices
%
%   - outdir
%     Output directory where the significance masks will be saved as .mat files
%
% Outputs:
%   - data_driven_mask
%     significance masks for the data-driven behavioral clusters
%
%   - hyp_driven_mask
%     significance masks for the hypothesis-driven behavioral clusters
%
% Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

% project_code_dir = fullfile(getenv('CBIG_CODE_DIR'),'stable_projects','predict_phenotypes', 'ChenTam2022_TRBPC');
project_code_dir = fullfile(getenv('IntExt_DIR'),'ABCD');
addpath(genpath(project_code_dir));

%% set common variables
% repdata_dir = fullfile(getenv('CBIG_REPDATA_DIR'),'stable_projects','predict_phenotypes','ChenTam2021_TRBPC');
PFM_dir = fullfile(getenv('IntExt_DIR'),'ABCD_KRR_output');

perm_total = 2000;
perm_per_file = 1000;
N_score = 33;
N_cat = 8; % number of hypothesis-driven clusters
N_state = 1;

%% compute average PFM in each network block
disp('-------- compute average PFM in each network block --------')
if ~exist(fullfile(PFM_dir,'PFM_network_mean.mat'),'file')
    PFM_network = CBIG_TRBPC_compute_network_mean_PFM(PFM_dir, N_score, N_state, PFM_dir);
else
    load(fullfile(PFM_dir,'PFM_network_mean.mat'),'PFM_network');
end

% %% data-driven behavior categories
% disp('-------- compute p-value for data-driven behavior categories --------')
% behav_cat = cell(N_cat,1);
% behav_cat{1} = [9:18, 20:21, 31:36]; % data-driven cognition
% behav_cat{2} = [1, 3:6, 23]; % data-driven mental health
% behav_cat{3} = [19, 22, 24:29]; % data-driven personality
% p_value_data = CBIG_TRBPC_compute_PFM_p_value(PFM_network, perm_dir, behav_cat, perm_per_file, perm_total);

%% hypothesis-driven behavior categories
disp('-------- compute p-value for hypothesis-driven behavior categories --------')
behav_cat{1} = [19:21,28:29,22,30]; % child internalizing
behav_cat{2} = [9,1,2,11,12,14,3,13]; % parent internalizing
behav_cat{3} = [4]; % parent thought problem
behav_cat{4} = [24]; % child thought problem
behav_cat{5} = [23,26,27,32:33]; % child externalizing
behav_cat{6} = [10,16,6:8]; % parent externalizing
behav_cat{7} = [25,31]; % child adhd
behav_cat{8} = [5,15,17:18]; % parent adhd
p_value_hyp = CBIG_TRBPC_compute_PFM_p_value(PFM_network, perm_dir, behav_cat, perm_per_file, perm_total);

[~,thr] = FDR(p_value_hyp(:),0.05);

%% compute significance masks for data-driven clusters
N_net = 18;
N_roi = 419;
% 
% significant_p = p_value_data < thr;
% data_driven_mask = zeros(N_roi,N_roi,N_state,N_cat);
% N_net_pair = N_net*(N_net+1)/2;
% ind = tril(ones(N_net,N_net))==1;
% for i = 1:N_state
%     for j = 1:N_cat
%         curr_p = significant_p((i-1)*N_net_pair+1:i*N_net_pair,j);
%         curr_net = zeros(N_net,N_net);
%         curr_net(ind) = curr_p;
%         curr_net = curr_net+curr_net';
%         data_driven_mask(:,:,i,j) = CBIG_TRBPC_network_average_back2FC(curr_net>0);
%     end
% end

%% compute significance masks for hypothesis-driven clusters

significant_p = p_value_hyp < thr;
hyp_driven_mask = zeros(N_roi,N_roi,N_state,N_cat);
N_net_pair = N_net*(N_net+1)/2;
ind = tril(ones(N_net,N_net))==1;
for i = 1:N_state
    for j = 1:N_cat
        curr_p = significant_p((i-1)*N_net_pair+1:i*N_net_pair,j);
        curr_net = zeros(N_net,N_net);
        curr_net(ind) = curr_p;
        curr_net = curr_net+curr_net';
        hyp_driven_mask(:,:,i,j) = CBIG_TRBPC_network_average_back2FC(curr_net>0);
    end
end

% save(fullfile(outdir,'PFM_significance_masks.mat'),'data_driven_mask','hyp_driven_mask');
save(fullfile(outdir,'PFM_significance_masks.mat'),'hyp_driven_mask');
rmpath(genpath(project_code_dir));
