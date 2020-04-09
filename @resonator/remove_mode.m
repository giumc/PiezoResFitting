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
            %remove graphics
            res.mode(n_old-i)=[];
            if mydelete(res.boundaries_bars(end-2:end))
                res.boundaries_bars(end-2:end)=[];
            end
            
            if mydelete([res.boundaries_edit{end-2:end}])
                res.boundaries_edit(end-2:end)=[];
            end
            if mydelete(res.param_name_labels(end-2:end))
                res.param_name_labels(end-2:end)=[];
            end
            if mydelete(res.param_value_labels(end-2:end))
                res.param_value_labels(end-2:end)=[];
            end
            if mydelete(res.optim_checkbox(end-2:end))
                res.optim_checkbox(end-2:end)=[];
            end
            res.update_fig;
            
        end
        
    end
    
    function flag=mydelete(obj)
        flag=false;
        if ~isempty(obj)
            if isvalid(obj)
                delete(obj);
                flag=true
            end
        end
    end
end
