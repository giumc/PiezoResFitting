function guess_coarse(res)

    
    
    tag = 'override'; % override previous values / bounds
    
    res.c0.set_value(   res.fit_c0  , tag );
    
    res.r0.set_value(...
        1/(2*pi*res.mode(1).fres.value*res.c0.value)/0.01,tag);

    res.rs.set_value(10);
    
    for i=1:length(res.mode)
        res.guess_mode(res,i);
    end
    
    
            
    res.set_default_boundaries;
    
end
