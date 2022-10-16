
function fit_all_modes(obj)

    startmsg=fprintf("Start fitting %s resonator\n",obj.tag);
    
    while length(obj.mode)>=1
    
        obj.remove_mode;
    
    end

    obj.setup_optim_text;
    
    for i=1:obj.max_modes
        
        if ~obj.add_mode
            
            break
            
        else
            
            obj.mode(i).fres.optimizable=false;
            
            obj.mode(i).kt2.optimizable=true;
            
            obj.mode(i).q.optimizable=true;
            
        end

    end
    
    obj.populate_optim_text;

    obj.c0.optimizable=true;

    obj.r0.optimizable=true;

    obj.rs.optimizable=true;

    obj.update_fig;

    obj.fit_until_stable;

    obj.gen_table();
    
    fprintf(repmat('\b',1,startmsg));
    
    obj.isoptimized=1;
    
end
