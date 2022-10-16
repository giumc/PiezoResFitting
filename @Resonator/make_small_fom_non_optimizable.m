function make_small_fom_non_optimizable(obj)
    
    for i=1:length(obj.mode)
        
        q=obj.mode(i).q;
        
        kt2=obj.mode(i).kt2;
        
        if q.value<1
            
            q.optimizable=false;
            
        end
        
        if kt2.value<0.001
           
            kt2.optimizable=false;
            
        end
        
    end

end