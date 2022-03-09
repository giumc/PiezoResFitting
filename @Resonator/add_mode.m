function flag=add_mode(obj,varargin)
       
    if isempty(obj.mode)
        
        obj.mode = struct (...
                'fres',obj.set_default_param(4),...
                'q',obj.set_default_param(5),...
                'kt2',obj.set_default_param(6));
            
    else
            
        n_old     =   length(obj.mode);

        obj.mode(n_old+1).fres=copy(obj.mode(n_old).fres);

        obj.mode(n_old+1).q=copy(obj.mode(n_old).q);

        obj.mode(n_old+1).kt2=copy(obj.mode(n_old).kt2);

    end

    for k=obj.n_param-2:obj.n_param

        opt_param=obj.get_param(k);

        opt_param.label=obj.param_name(k);

        opt_param.optimizable=true;

    end

    obj.update_fig;

    flag    =  obj.guess_mode(length(obj.mode));

    if ~flag

        obj.remove_mode;

    end
    
end
