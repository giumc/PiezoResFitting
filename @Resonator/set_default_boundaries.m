function set_default_boundaries(res)
    %fprintf('\nSetting default boundaries.\n');
    
    if isempty(res.y_meas)
        
        fprintf('Empty measure: No bounds generated\n');
        return;
        
    end
    
    res.c0.rescale_factor=0.5;
    
    res.r0.rescale_factor=0.5;
    
    res.rs.rescale_factor=0.5;
    
    for i=1:length(res.mode)
    
        res.mode(i).q.rescale_factor=0.5;
        
        res.mode(i).kt2.rescale_factor=0.5;
        
        res.mode(i).fres.rescale_factor=0.001;
               
    end
    
end
