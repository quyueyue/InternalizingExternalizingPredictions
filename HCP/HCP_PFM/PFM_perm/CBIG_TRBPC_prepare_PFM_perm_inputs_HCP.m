function CBIG_TRBPC_prepare_PFM_perm_inputs_HCP(feature_files, KRR_dir, outdir, seed_idx)

% CBIG_TRBPC_prepare_PFM_perm_inputs(feature_files, multiKRR_dir, outdir)
% 
% This function prepares the necessay inputs for the permutation test of
% predictive feature matrices
%
% Inputs:
%   - feature_files
%
%   - KRR_dir
%     The directory wherre the KRR results are
%
%   - outdir
%     Output direcotry
%
% Outputs:
%   3 files will be saved in the outdir:
%   1) A mat file containing network average connectivity
%   2) A mat file containing the cross-validation splits
%   3) A mat file containing the behavioral score after regressing out
%   covariates
%
% Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

% project_code_dir = fullfile(getenv('CBIG_CODE_DIR'),'stable_projects','predict_phenotypes', 'ChenTam2022_TRBPC');
project_code_dir = fullfile(getenv('IntExt_DIR'),'ABCD')
addpath(genpath(project_code_dir));


%% get FC averaged in ech network-pair blocks
load(feature_files);
% N_task = length(feature_files);
% load(feature_files{1});
[~,N_sub] = size(features_rs);

N_net = 18;
N_net_pair = N_net*(N_net+1)/2;
FC_network_mean = zeros(N_net_pair,N_sub);

% for i = 1:N_task
% load(feature_files{i});
features_rs = normalize(features_rs,'center');
features_rs = normalize(features_rs,'norm',2);
for j = 1:N_sub
    curr_FC = features_rs(:,j);
disp('Computing average FC within network...');
    mean_FC = CBIG_TRBPC_compute_FC_average_within_network(CBIG_TRBPC_FC_vector2mat(curr_FC));
    FC_network_mean(:,j) = mean_FC;
end
% end
disp('Writing network mean FC file...');
save(fullfile(outdir,'FC_network_mean.mat'), 'FC_network_mean');

%% load cross-validation split

seed = strcat('seed_',num2str(seed_idx));
disp(seed);
if ~exist(fullfile(outdir,seed),'dir')
    mkdir(fullfile(outdir,seed));
end
sub_fold_file = dir(fullfile(KRR_dir, seed, 'results', '*sub_list.mat'));
if length(sub_fold_file) ~= 1
    error('There should be one and only one sub_fold file in the KRR directory');
end
load(fullfile(KRR_dir, seed, 'results', sub_fold_file.name));
N_fold = length(sub_fold);
folds = cell(N_fold,1);
for i = 1:N_fold
    test_ind = sub_fold(i).fold_index;
    train_ind = ~test_ind;
    folds{i} = train_ind;
end
disp('Writing cross validation subfold file...')
save(fullfile(outdir,seed,'folds.mat'), 'folds');


%% load behavior score after regression

y_regress = cell(N_fold,1);
for i = 1:N_fold
    load(fullfile(KRR_dir, ['seed_' num2str(seed_idx)], 'results', 'y', ['fold_' num2str(i)], 'y_regress_KRR_features_rs_752.mat'),'y_resid');
    y_regress{i} = y_resid;
end
save(fullfile(outdir,seed,'y_regress.mat'), 'y_regress');


rmpath(genpath(project_code_dir));
end
