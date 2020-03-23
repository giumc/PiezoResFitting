function add_mode(res,varargin)
    n=1;
    if ~isempty(varargin)
        if isnumeric(varargin{1})
            n=floor(varargin{1});
        end
    end
    
    n_old     =   length(res.mode);
    for i=1:n
        new_mode=n_old+i;
        res.mode(new_mode).fres=copy(res.mode(new_mode-1).fres);
        res.mode(new_mode).q=copy(res.mode(new_mode-1).q);
        res.mode(new_mode).kt2=copy(res.mode(new_mode-1).kt2);
        
        %update name
        for k=res.n_param-2:res.n_param
            name=res.param_name(k);
            opt_param=res.get_param(k);
            opt_param.label=name;
        end
            
        res.guess_mode(new_mode);
        
    end        
    res.setup_bars;
    res.update_fig;
end
