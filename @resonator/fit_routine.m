function fit_routine(r)

% r.fit_resonance;
loop=true;
iter=0;

for i=1:length(r.mode)
    r.mode(i).fres.optimizable=false;
end
while loop
%     if iter>0
%         r.c0.optimizable=0;
%         r.update_fig;
%     end
    
    r.fit_resonance;
    iter=iter+1;
    
    err(iter)   = r.error_function (r.optim_array);
    x0  = r.optim_array;  
    
    for i=1:length(x0)
        if x0(i)>0.8||x0(i)<0.2
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
