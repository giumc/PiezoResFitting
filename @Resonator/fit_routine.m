function fit_routine(obj)

    startmsg=fprintf("Start fitting %s resonator\n",obj.tag);
    
    obj.setup_optim_text;
  
    while true
                
        obj.populate_optim_text;
            
        % set fres non optimizable for all modes fres
        
        for i=1:length(obj.mode)
            
            obj.mode(i).fres.optimizable=false;
            
        end
        
        obj.update_fig;
        
        flag=obj.fit_until_stable;
        
        if flag==-1
            
            break
            
        end
        
        if length(obj.mode)==obj.max_modes 
            
            break
           
        else
            
            if ~obj.add_mode
                
                break
                
            end
            
        end

    end
    
    obj.gen_table();
    
    fprintf(repmat('\b',1,startmsg));
    
    obj.isoptimized=1;
    
end
