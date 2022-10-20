function flag=fit_until_stable(obj)
    
    iter=0;
    
    params=obj.get_opt_params;
    
    while true
    
        x0=obj.get_opt_array;
        
        if isempty([x0.v])

            break

        else

            iter=iter+1;

            itermsg=fprintf("Iteration n %d",iter);
            
            obj.update_fig;

            flag=obj.run_optim();
            
            if flag==-1

                break

            end
            
            fprintf(repmat('\b',1,itermsg));

            xnew  = obj.get_opt_array;

            for i=1:length([xnew.v])
                
                if xnew(i).v>(1-obj.opt_threshold)||xnew(i).v<obj.opt_threshold

                    params(xnew(i).i).rescale_bounds;
                    
                end

                if abs((xnew(i).v-x0(i).v)/x0(i).v)<obj.opt_threshold/2

                    params(xnew(i).i).optimizable=0;

                end

            end
            
            obj.make_small_fom_non_optimizable;
    
        end
        
    end
    
end