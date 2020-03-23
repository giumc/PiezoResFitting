function remove_mode(res,varargin)
    n=1;
    if ~isempty(varargin)
        if isnumeric(varargin{1})
            n=floor(varargin{1});
        end
    end
    
    n_old     =   length(res.mode);
    for i=0:(n-1)
        if length(res.mode)==1
            break
        else
            res.mode(n_old-i)=[];
            delete(res.boundaries_bars(end-2:end));
            res.boundaries_bars(end-2:end)=[];
            delete([res.boundaries_edit{end-2:end}]);
            res.boundaries_edit(end-2:end)=[];
            delete(res.param_name_labels(end-2:end));
            res.param_name_labels(end-2:end)=[];
            delete(res.param_value_labels(end-2:end));
            res.param_value_labels(end-2:end)=[];
            delete(res.optim_checkbox(end-2:end));
            res.optim_checkbox(end-2:end)=[];
            drawnow;
        end
        
    end
    
    %remove graphics
    
end
