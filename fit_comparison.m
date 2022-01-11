function r_stack=fit_comparison(r,modes)
    
    r_stack=[];
    
    for i=1:length(modes)
        
        r_stack=[r_stack,copy(r)];
        
        this_r=r_stack(end);
        
        this_r.max_modes=modes(i);
        
        this_r.reset;
        
        this_r.fit_routine;
        
    end
    
end
    
    

