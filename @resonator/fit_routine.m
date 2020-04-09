function fit_routine(r)

    max_modes=r.max_modes;

    loop=true;
    iter=0;

    %get who's optimizable at the beginning
    for i=1:r.n_param
        isoptim(i)=r.get_param(i).optimizable; 
    end

    init_param=r.n_param;

    while loop
        % re-set optimizability of parameters
        for i=1:r.n_param
            if i<=init_param
                r.get_param(i).optimizable=isoptim(i); 
            else
                r.get_param(i).optimizable=true; 
            end
        end

        % set fres non optimizable for all modes fres
        for i=1:length(r.mode)
            r.mode(i).fres.optimizable=false;
        end
        
        r.update_fig;
        drawnow;

        %keep optimizing until boundaries are stable
        subloop=true;
        while subloop
            j=1;
            opt_par=[];

            %check who's optimizable now
            for i=1:r.n_param
                tot_param(i)=r.get_param(i);
                if tot_param(i).optimizable
                    opt_par(j)=i;
                    j=j+1;
                end
            end
            %get initial array of optimizands value
            x0=r.optim_array;
            if isempty(x0)
                break;
            end
            flag=r.run_optim();
            iter=iter+1;

            %get final array of optimizands value
            xnew  = r.optim_array;


            for i=1:length(opt_par)
                %if values don't change, don't optimize later
                if abs((xnew(i)-x0(i))/x0(i))<0.01
                    r.get_param(opt_par(i)).optimizable=0;
                end

            end

            for i=1:length(x0)
                %if values are too close to boundaries, update boundaries
                %and reoptimize
                if xnew(i)>0.95||xnew(i)<0.05
                    r.set_default_boundaries;
                    r.update_fig;                  
                    break
                else
                    %otherwise, add a mode and go back to main loop
                    if i==length(x0)
                        
                        subloop=false;
                        %if max modes reached, exit routine
                        if length(r.mode)>max_modes
                            loop=false;      
                        else
                            r.add_mode();
                            
                        end
                    end
                end
            end

            %if user stops optimization,exit routine
            if flag==-1
                subloop=false;
            end

        end
        %if user stops optimization,exit routine
        if flag==-1
            loop=false;
        end

    end

end
