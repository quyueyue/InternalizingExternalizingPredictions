function param = CBIG_KRRworkflow_parseInput(varargin)

varnames = {'sub_fold', 'y', 'covariates', 'num_inner_folds', 'outdir', ...
    'outstem', 'with_bias', 'ker_param', 'threshold','group_kernel','domain', 'metric'};

for i = 1:(numel(varnames)-6)
    if(length(varargin)<i || isempty(varargin{i}))
        error('Variable ''%s'' is needed.', varnames{i})
    else
        if(i~=4 && i~=5 && i~=6)
            % sub_fold, y, covariates, feature_mat are loaded from .mat files.
            currvar = load(varargin{i});
            names = fieldnames(currvar);
            if(any(strcmp(names, varnames{i})))
                currname = varnames{i};
            else
                currname = names{1};
            end
            param.(varnames{i}) = currvar.(currname);
        else
            % num_inner_folds or outdir are directly set as fields of param
            param.(varnames{i}) = varargin{i};
        end
    end
end

% default of with_bias flag
if(length(varargin)<7 || isempty(varargin{7}))
    param.with_bias = 1;
else
    param.with_bias = varargin{7};
end

% default of ker_param
if(length(varargin)<8 || isempty(varargin{8}) || strcmpi(varargin{8}, 'none'))
    param.ker_param.type = 'corr';
    param.ker_param.scale = NaN;
else
    load(varargin{8})
    param.ker_param = ker_param;
end

% default of threshold
if(length(varargin)<9 || isempty(varargin{9}) || strcmpi(varargin{9}, 'none'))
    param.threshold = 0.5;
else
    load(varargin{9})
    param.threshold = threshold;
end

% default of group_kernel
if(length(varargin)<10 || isempty(varargin{10}) || strcmpi(varargin{10}, 'none'))
    param.group_kernel = 'none';
else
    load(varargin{10})
    param.group_kernel = group_kernel;
end

% default of domain
if(length(varargin)<11 || isempty(varargin{11}) || strcmpi(varargin{11}, 'none'))
    param.domain = [0 20];
else
    load(varargin{11})
    param.domain = domain;
end

% default of metric
if(length(varargin)<12 || isempty(varargin{12}))
    param.metric = 'pCoD';
else
    param.metric = varargin{12};
end

end
