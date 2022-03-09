function fit_routine(obj)

    startmsg=fprintf("Start fitting %s resonator\n",obj.tag);
    
    obj.setup_optim_text;
  
    while true
                
        obj.populate_optim_text;
            
        for i=1:length(obj.mode)
            
            obj.mode(i).fres.optimizable=false;
            
            obj.mode(i).kt2.optimizable=true;
            
            obj.mode(i).q.optimizable=true;
            
        end

        obj.c0.optimizable=true;

        obj.r0.optimizable=true;

        obj.rs.optimizable=true;

        obj.update_fig;
        
        itermsg=fprintf("fitting mode %d\n",length(obj.mode));
        
        flag=obj.fit_until_stable;
        
        fprintf(repmat('\b',1,itermsg));
        
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
