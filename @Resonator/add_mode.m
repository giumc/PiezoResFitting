function flag=add_mode(obj,varargin)
       
    if isempty(obj.mode)
        
        obj.mode = struct (...
                'fres',obj.set_default_param(4),...
                'q',obj.set_default_param(5),...
                'kt2',obj.set_default_param(6));
            
    else
            
        n_old     =   length(obj.mode);

        for i=1:n_old

            new_mode=n_old+i;

            obj.mode(new_mode).fres=copy(obj.mode(new_mode-1).fres);

            obj.mode(new_mode).q=copy(obj.mode(new_mode-1).q);

            obj.mode(new_mode).kt2=copy(obj.mode(new_mode-1).kt2);

            %update name
            for k=obj.n_param-2:obj.n_param

                name=obj.param_name(k);

                opt_param=obj.get_param(k);

                opt_param.label=name;

            end

            %make new mode optimizable

            for k=obj.n_param-2:obj.n_param

                opt_param=obj.get_param(k);

                opt_param.optimizable=true;

            end

            obj.update_fig;

            flag    =  obj.guess_mode(new_mode);

            if ~flag

    %             fprintf("Cannot find another mode\n");

                if ~(new_mode==1)

                    obj.remove_mode;

                end

                break

            end

        end
    
end
