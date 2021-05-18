function fit_all_modes(r)

    startmsg=fprintf("Start fitting %s resonator \n",r.tag);
    max_modes=r.max_modes;
    iter = 0;
    
    %initialize all modes
    for i=1:max_modes
        n0=length(r.mode);
        r.add_mode;
        r.mode(end).kt2.set_value(0.005,'override');
        nnew=length(r.mode);
        if nnew==n0
            break
        end
    end
    
    % set fres non optimizable for all modes fres
    for i=1:length(r.mode)
        
        r.mode(i).fres.optimizable=false;
        
    end
    if ~isempty(r.figure)
        r.setup_optim_text;
    end

    r.update_fig;
    drawnow;
    
    loop = true;
    
    %loop optimization until values are stable
    while loop
        
        
        if ~isempty(r.optim_text)
            r.populate_optim_text;
        end
        
        opt_num=0;
        opt_par=[];

        %check who's optimizable now
        for i=1:r.n_param
            
            tot_param(i)=r.get_param(i);
            
            if tot_param(i).optimizable
                
                opt_num=opt_num+1;
                opt_par(opt_num)=i;

            end
            
        end
        
        %get initial array of optimizands value
        x0=r.get_optim_array;
        iter = iter+1;
         
        itermsg=fprintf("Iteration n %d",iter);
            
        if isempty(x0)
            
            break;
            
        else

            if(iter>0)

                fprintf(repmat('\b',1,itermsg));
                drawnow;

            end

            drawnow;

            flag=r.run_optim();

            %get final array of optimizands value
            xnew  = r.get_optim_array;

            %if values don't change, don't optimize later
            for i=1:length(opt_par)

                if abs((xnew(i)-x0(i))/x0(i))<0.025

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
                    if i==length(x0)

                        loop=false;

                    end
                end
            end
        end

        %if user stops optimization,exit routine
        if flag==-1
            loop=false;
        end
        
        
    end
    
    r.gen_table();
    fprintf(repmat('\b',1,startmsg));
        
    r.isoptimized=1;
    
    if ~isempty(r.optim_text)
        delete(r.optim_text);
        r.optim_text=[];
    end
    
    r.isoptimized=1;
    
end


