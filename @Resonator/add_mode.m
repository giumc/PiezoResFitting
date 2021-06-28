function flag=add_mode(res,varargin)

    flag    =   true;
    
    n=1;
    
    if ~isempty(varargin)
        
        if isnumeric(varargin{1})
            
            n=floor(varargin{1});
            
        end
        
    end
    
    n_old     =   length(res.mode);
    
    for i=1:n
        
        new_mode=n_old+i;
        
        if new_mode==1
            
            res.mode = struct (...
                'fres',res.set_default_param(4),...
                'q',res.set_default_param(5),...
                'kt2',res.set_default_param(6));
            
        else
            
            res.mode(new_mode).fres=copy(res.mode(new_mode-1).fres);
            
            res.mode(new_mode).q=copy(res.mode(new_mode-1).q);
            
            res.mode(new_mode).kt2=copy(res.mode(new_mode-1).kt2);
        
        end
        
        %update name
        for k=res.n_param-2:res.n_param
            
            name=res.param_name(k);
            
            opt_param=res.get_param(k);
            
            opt_param.label=name;
            
        end
        
        %make new mode optimizable
        
        for k=res.n_param-2:res.n_param
            
            opt_param=res.get_param(k);
            
            opt_param.optimizable=true;
            
        end
        
        res.update_fig;
        
        flag    =  res.guess_mode(new_mode);
        
        if ~flag
            
%             fprintf("Cannot find another mode\n");
    
            if ~(new_mode==1)
                
                res.remove_mode;
            
            end
            
            break
            
        end
        
    end
    
end
