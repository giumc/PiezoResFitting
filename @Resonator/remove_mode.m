function remove_mode(res,varargin)

    n=1;
    
    if ~isempty(varargin)
        
        if isnumeric(varargin{1})
            
            n=floor(varargin{1});
            
        end
        
    end
    
    n_old     =   length(res.mode);
    
    for i=0:n-1
        
        if isempty(res.mode)
            
            break
            
        else
            
            %remove graphics
            res.mode(n_old-i)=[];
            
            if ~isempty(res.boundaries_bars)
                
                if mydelete(res.boundaries_bars(end-2:end))
                    
                    res.boundaries_bars(end-2:end)=[];
                    
                end
                
            end
            
            if ~isempty(res.boundaries_edit)
                
                x=[res.boundaries_edit{end-2:end}];
                
                if mydelete(x(1:2:end)) && mydelete(x(2:2:end))
                    
                    res.boundaries_edit(end-2:end)=[];
                    
                end
                
            end
            
            if  ~isempty(res.param_name_labels)
                
                if mydelete(res.param_name_labels(end-2:end))
                    
                    res.param_name_labels(end-2:end)=[];
                    
                end
                
            end
            
            if ~isempty(res.param_value_labels)
                
                if mydelete(res.param_value_labels(end-2:end))
                    
                    res.param_value_labels(end-2:end)=[];
                    
                end
                
            end
            
            if ~isempty(res.optim_checkbox)
                
                if mydelete(res.optim_checkbox(end-2:end))
                    
                    res.optim_checkbox(end-2:end)=[];
                    
                end
                
            end
                        
        end
        
    end
    
    res.update_fig;
    
    function flag=mydelete(obj)
        
        flag=false;
        
        if ~isempty(obj)
            
            if isvalid(obj)
                
                delete(obj(end-2:end));
                
                flag=true;
                
            end
        end
    end
end
