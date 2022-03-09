function make_small_fom_non_optimizable(obj)
    
    for i=1:length(obj.mode)
        
        fom=obj.get_fom(i);
        
        if fom<0.1
            
            obj.mode(i).q.optimizable=false;
           
            obj.mode(i).kt2.optimizable=false;
            
        end
        
    end

end