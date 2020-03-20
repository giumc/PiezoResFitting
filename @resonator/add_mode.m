function add_mode(res,varargin)
    n=1;
    if ~isempty(varargin)
        if isnumeric(varargin{1})
            n=floor(varargin{1}));
        end
    end
    
    n_old     =   length(res.mode);
    
    %fprintf('\nChanging number of modes from %d to %d.\n',n_old,n_new);
    
    res.set_default_boundaries;
    res.update_fig;
end
