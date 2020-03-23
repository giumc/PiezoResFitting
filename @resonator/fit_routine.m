function fit_routine(r)

loop=true;
iter=0;

while loop

    for i=1:r.n_param
        r.get_param(i).optimizable=true;       
    end
    
    for i=1:length(r.mode)
        r.mode(i).fres.optimizable=false;
        r.update_fig;
        drawnow;
    end
    
    
    %get all optimizable parameters
    
    subloop=true;
    while subloop
        j=1;
        opt_par=[];
        for i=1:r.n_param
            tot_param(i)=r.get_param(i);
            if tot_param(i).optimizable
                opt_par(j)=i;
                j=j+1;
            end
        end
        x0=r.optim_array;
        if isempty(x0)
            break;
        end
        flag=r.fit_resonance;
        iter=iter+1;

    %     err(iter)   = r.error_function (r.optim_array);
        xnew  = r.optim_array;

        for i=1:length(opt_par)
            if abs((xnew(i)-x0(i))/x0(i))<0.05
                r.get_param(opt_par(i)).optimizable=0;
                r.update_fig;
                drawnow;
            end
        end

        for i=1:length(x0)
            if xnew(i)>0.9||xnew(i)<0.1
                r.set_default_boundaries;
                r.update_fig;
                break
            else
                if i==length(x0)
                    r.add_mode();
                    subloop=false;
                    if length(r.mode)==6
                        loop=false;
                        
                    end
                end
            end
        end
        if flag==-1
            subloop=false;
        end
    end
    
    if flag==-1
        loop=false;
    end
    
end
