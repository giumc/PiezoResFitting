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

            flag=obj.run_optim();
            
            if flag==-1

                break

            end
            
            fprintf(repmat('\b',1,itermsg));

            xnew  = obj.get_opt_array;

            for i=1:length([xnew.v])
                
                if xnew(i).v>0.95||xnew(i).v<0.05

                    obj.set_default_boundaries;

                    obj.update_fig; 
                    
                    break

                else
                    
                    if abs((xnew(i).v-x0(i).v)/x0(i).v)<0.025
                        
                        params(xnew(i).i).optimizable=0;

                    end

                end

            end

        end
        
    end
    
end