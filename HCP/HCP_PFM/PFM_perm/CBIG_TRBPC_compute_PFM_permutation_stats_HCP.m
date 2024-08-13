function CBIG_TRBPC_compute_PFM_permutation_stats_HCP(FC_mean_file, y_file, krr_folds,...
    perm_seed_start, perm_num, family_list, subject_list, outdir, seed_idx)

% CBIG_TRBPC_compute_PFM_permutation_stats(FC_mean_file, y_file, krr_folds, ...
%    perm_seed_start, perm_num, outdir)
%
% This function compute the predictive-feature vaules averaged within
% network blocks when the target variables are permuted.
%
% Inputs:
%   - FC_mean_file
%     A .mat file containing the functional connectivity averaged within
%     network blocks. This file is generated by "CBIG_TRBPC_prepare_PFM_inputs.m"
%
%   - y_file
%     A .mat file contains the target variable after regressing out covariates
%     for each cross validation splits. This file is generated by 
%     "CBIG_TRBPC_prepare_PFM_inputs.m"
%
%   - cov_mat
%     A .mat file contains the covaritesof the regression model. A
%     varaible named "covariates" is stored in the file. "covariates"
%     is a matrix of size #subjects X #covariates
%
%   - krr_folds
%     A .mat file containing the indices of training subjects in each cross
%     validation splits. This file is generated by "CBIG_TRBPC_prepare_PFM_inputs.m"
%
%   - perm_seed_start
%     A scalar. The function will do the permutation N_perm times using
%     permutation seed from perm_seed_start to perm_seed_start+N_perm-1
%
%   - perm_num
%     Number of permutation
%
%   - family_list
%     A csv containing the family IDs of subjects.
%
%   - subject_list
%     A text file where each line is the subject ID to be extracted from family_list.
%
%   - outdir
%     Output directory for the permutation results
%
% Outputs:
%     Predictive-feature vaules averaged within network blocks when the target variables 
%     are permuted will be stored in outdir
%
% Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

%% parse input
% project_code_dir = fullfile(getenv('CBIG_CODE_DIR'),'stable_projects','predict_phenotypes', 'ChenTam2022_TRBPC');
project_code_dir = fullfile(getenv('IntExt_DIR'),'ABCD');
addpath(genpath(project_code_dir));

if(isstr(perm_seed_start))
    perm_seed_start = str2num(perm_seed_start);
end

if(isstr(perm_num))
    perm_num = str2num(perm_num);
end

if ~exist(outdir,'dir')
	mkdir(outdir);
end

% get subjects 
fid = fopen(subject_list,'r');
file = textscan(fid, '%d');
fclose(fid);
subjects = file{:};

% get families
sub_table = readtable(family_list);
[~, loc] = ismember(subjects,sub_table.Subject); % find indices in the sub_table (1113 subjs in total) corresponding to the subset of 752 subjects used for analysis
family_all = sub_table.Family_ID(loc);
[~, ~, family_ind] = unique(family_all); % index of family ID of each subject in family_all (for eg, subject 1's family ID is the 361th family ID in family_all)
N_family = max(family_ind); % 385 families in total
for i = 1:N_family
	family_count(i,:) = sum(family_ind == i);
end

%% load data
load(FC_mean_file, 'FC_network_mean');
N_edge = size(FC_network_mean,1);

load(y_file, 'y_regress');
N_score = size(y_regress{1},2);

load(krr_folds);
folds = folds(:);
N_fold = length(folds);
N_sub = length(folds{1});

%% compute PFM under permuted target variable
PFM_score_perm = zeros(N_edge,N_score,perm_num);

for i = 1:perm_num
    % permute behavior within site
    % split into max(family_count) groups
    perm_group = zeros(length(family_ind),1); % coding for which families are included in the permutation
    rng(i+perm_seed_start-1);
    for k = 1:N_family
        sorting_order = datasample([1:max(family_count)],family_count(k),'Replace', false); % max(family_count)=5; family_count(k) random samples of 1:5;
        % family_count(k)=number of subjects who belong to the kth
        % family ID
        % ensures that subjects who belong to the same family are
        % assigned to different perm group ind (perm_group ind = 1:5; different
        % because replace=false)
        perm_group(find(family_ind == k)) = sorting_order; % perm_group(find(family_ind == k)) extracts the perm_group indices for subjects belonging to the kth family
        % perm_group is a 1*752 vector
    end
    % permute within groups
    perm_ind = 1:length(family_all);
    for n = 1:max(family_count) % equivalent to: for perm_group_id = 1:5
        tmp = perm_ind(perm_group == n); % subset out y_regress values for all subjects under each perm_group
        tmp = tmp(randperm(length(tmp))); % randomly permute the order of y_tmp
        perm_ind(perm_group == n) = tmp; % update y_resid in each perm group with the permutated y values (y_tmp)
    end
    activation_score_fold = zeros(N_edge,N_score,N_fold);
    for j = 1:N_fold
    % compute activation
        train_ind = folds{j}; % need to generate folds
        y_resid = y_regress{j};
        y_perm = y_resid(perm_ind,:);
        y_perm_train = y_perm(train_ind,:); 
        features_train = FC_network_mean(:,train_ind);
        curr_cov = CBIG_TRBPC_compute_covariance(features_train',y_perm_train);
        activation_score_fold(:,:,j) = bsxfun(@times,curr_cov,1./std(y_perm_train));
    end
    PFM_score_perm(:,:,i) = mean(activation_score_fold,3);
end

seed=strcat('seed_',num2str(seed_idx));
save([outdir seed '/PFM_score_perm_start' num2str(perm_seed_start) '.mat'],'PFM_score_perm');
rmpath(genpath(project_code_dir));
end
