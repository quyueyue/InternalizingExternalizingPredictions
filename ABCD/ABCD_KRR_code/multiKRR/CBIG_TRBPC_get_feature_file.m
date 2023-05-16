function CBIG_TRBPC_multiKRR_get_inputs(analysis_type,outdir)

% This function concatenantes feature matrices across all brain states in a
% cell array to pass as an input parameter to multiKRR

input_dir = fullfile('/gpfs/milgram/project/holmes/yq222/','FYP','ABCD'); 
if isequal(analysis_type,'multiKRR')
    feature_files = cell(4,1);
    feature_files{1} = fullfile(input_dir,'FC_subjects_all_task_all_score_rs_bp_sm6.mat');
    feature_files{2} = fullfile(input_dir,'FC_subjects_all_task_all_score_mid_bp_sm6.mat');
    feature_files{3} = fullfile(input_dir, 'FC_subjects_all_task_all_score_sst_bp_sm6.mat');
    feature_files{4} = fullfile(input_dir, 'FC_subjects_all_task_all_score_nback_bp_sm6.mat');
    save(fullfile(outdir, 'FC_all.mat'), 'feature_files');
elseif isequal(analysis_type,'KRR')
    feature_files = cell(1,1);
    feature_files{1} = fullfile(input_dir,'FC_subjects_all_task_all_score_rs_bp_sm6.mat');
    save(fullfile(outdir, 'FC_rs.mat'), 'feature_files');
else
    print('Type of analysis not supported.');
end
