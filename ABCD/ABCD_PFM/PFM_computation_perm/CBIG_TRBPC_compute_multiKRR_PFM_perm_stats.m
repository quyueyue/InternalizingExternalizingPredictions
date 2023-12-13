function CBIG_TRBPC_compute_multiKRR_PFM_perm_stats(multiKRR_dir, feature_file, outstem, score_ind, perm_seed_start, ...
N_perm,site_list,outdir)

% CBIG_TRBPC_compute_multiKRR_acc_perm(multiKRR_dir,outstem,score_ind,perm_seed_start,N_perm,site_list,outdir)
%
% This function performs the permutation test for the multiKRR model and
% saves out the prediction accuracies of the permutation test
%
% Inputs:
%   - multiKRR_dir:
%     The directory wherre the multiKRR results are
%
%   - outstem
%     A string appended to the filename to specify the output files in the
%     multiKRR prediction. Must be the same as the input argument `outstem`
%     when you perform multiKRR
%
%   - score_ind
%     A scalar. The index of the score you want to perfom the permutation test.
%     Range from 1 to # Target Variables in your kernel regression
%
%   - perm_seed_start
%     A scalar. The function will do the permutation N_perm times using
%     permutation seed from perm_seed_start to perm_seed_start+N_perm-1
%
%   - N_perm
%     Number of permutation
%
%   - site_list
%     A text file where each line is the site ID of one subject. Permutation
%     will only be performed within sites
%
%   - outdir
%     Output directory for the permutation results
%
% Outputs:
%    prediction accuracies of the permutation test will be saved in the
%    outdir
%
% Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

project_code_dir = fullfile(getenv('IntExt_DIR'),'ABCD');
paths = genpath(project_code_dir);
addpath(paths)

if ~exist(outdir,'dir')
    mkdir(outdir)
end

if(isstr(score_ind))
    score_ind = str2num(score_ind);
end

%% load site ID
site_all = CBIG_text2cell(site_list);
[~, ~, site_ind] = unique(site_all);
N_site = max(site_ind);

%% load cross-validation split
sub_fold_file = dir(fullfile(multiKRR_dir,'*sub_list.mat'));
if length(sub_fold_file) ~= 1
    error('There should be one and only one sub_fold file in the multiKRR directory');
end
load(fullfile(multiKRR_dir,sub_fold_file.name));
N_fold = length(sub_fold);

%% load and normalize features
load(feature_file);
num_kernel = length(feature_files);
FC_all = CBIG_TRBPC_load_mat(feature_files{1});
[N_edge,N_sub] = size(FC_all);

features_all = zeros(N_edge,N_sub,num_kernel);
for i = 1:num_kernel
    FC_all = CBIG_TRBPC_load_mat(feature_files{i});
    FC_all = normalize(FC_all,'center');
    FC_all = normalize(FC_all,'norm',2);
    features_all(:,:,i) = FC_all;
    clear FC_all;
end

%% compute FSM
FSM_all = zeros(N_sub,N_sub,num_kernel);
for i = 1:num_kernel
    FSM_all(:,:,i) = corr(features_all(:,:,i));
end
%% compute permutation results
PFM_all_folds = zeros(N_edge*num_kernel,N_perm);

for i = 1:N_fold
    if(~exist(['/home/yq222/scratch60/PFM_score' num2str(score_ind) '_fold' num2str(i) '.mat'], 'file'))
        disp(['fold ' num2str(i)]);
        % load target variable and selected hyperparameters
        load([multiKRR_dir '/optimal_acc/fold_' num2str(i) '/acc_all_score.mat']);
        load([multiKRR_dir '/y/fold_' num2str(i) '/y_regress_all_score.mat']);
        y_resid = y_resid(:,score_ind);
        
        lambda_vect = opt_hyp{score_ind};
        test_ind = sub_fold(i).fold_index;
        train_ind = ~test_ind;
        
        FSM_train = FSM_all(train_ind,train_ind,:);
    %     FSM_pred = FSM_all(test_ind,train_ind,:);
        
        % number of subjects
        num_train_subj = size(FSM_train,1);
    %     num_test_subj = size(FSM_pred,1);
        
        % compute intermediate matrices
    %     FSM_tmp = reshape(FSM_pred,num_test_subj, num_train_subj*num_kernel);
        K_tmp = repmat(reshape(FSM_train,num_train_subj,num_train_subj*num_kernel),...
            num_kernel,1);
        kr_eye_tmp = eye(num_kernel*num_train_subj);
        kr_lambda_tmp = reshape(repmat(lambda_vect,num_train_subj,1),...
            num_train_subj*num_kernel,1);
        kr_tmp = bsxfun(@times, kr_eye_tmp, kr_lambda_tmp);
        K_tmp = K_tmp + kr_tmp;
        
        % training
        X = ones(num_train_subj*num_kernel,1);
        inv_K_tmp = inv(K_tmp);
        beta_pre = (X' * (inv_K_tmp * X)) \ X' * inv_K_tmp;
        parfor j = 1:N_perm
            % permute y
            rng(j+perm_seed_start-1);
            y_perm = y_resid;
            for k = 1:N_site
                y_tmp = y_perm(site_ind == k);
                y_tmp = y_tmp(randperm(length(y_tmp)));
                y_perm(site_ind == k) = y_tmp;
            end
            y_train_resid = y_perm(train_ind);
            
            % prediction
            y_tmp = repmat(y_train_resid,num_kernel,1);
            beta = beta_pre * y_tmp;
            alpha = inv_K_tmp * (y_tmp - X * beta);
            y_predicted = reshape(FSM_train,num_train_subj,...
            num_train_subj*num_kernel)*alpha + ones(num_train_subj,1) .* beta;
            % compute predictive-feature matrices
            features_train = zeros(N_edge*num_kernel,num_train_subj);
            for curr_kernel = 1:num_kernel
                features_train(1+(curr_kernel-1)*N_edge:curr_kernel*N_edge,:)...
                    = features_all(:,train_ind,curr_kernel);
            end
            PFM_all_folds(:,j) = PFM_all_folds(:,j) + (bsxfun(@minus,features_train',mean(features_train'))'*bsxfun(@minus,y_predicted,mean(y_predicted))/(size(features_train',1)-1))/std(y_predicted);
        end
        save(['/home/yq222/scratch60/PFM_score' num2str(score_ind) '_fold' num2str(i) '.mat'],'PFM_all_folds','-v7.3');
    end
end
% average over 120 cv folds
PFM_mean_fold=PFM_all_folds/120;
save([outdir '/PFM_score' num2str(score_ind) '_mean_fold.mat'],'PFM_mean_fold','-v7.3');
end

