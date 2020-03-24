function guess_coarse(res)

    if isempty(res.y_meas)
        fprintf('No measured SParam was found,so no coarse fitting can be generated\n');
        return;
    else
        
    end
    
    if isempty(res.mode)
        fprintf('The ronator has no modes, use set_number_modes(X) method to add one\n');
        return
    end
    
    tag = 'override'; % override previous values / bounds
    
    res.c0.set_value(   res.fit_c0  , tag );
    
    for i=1:length(res.mode)
        res.guess_mode(i);
    end
    
    res.r0.set_value(...
        1/(2*pi*res.mode(1).fres.value*res.c0.value)/0.01,tag);

    res.rs.set_value(2,tag);         
    res.set_default_boundaries;
    
end
