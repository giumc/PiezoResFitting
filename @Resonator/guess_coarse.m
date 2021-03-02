function guess_coarse(res)

    if isempty(res.y_meas)
        fprintf('No measured SParam was found,so no coarse fitting can be generated\n');
        return;

    end
    
    tag = 'override'; % override previous values / bounds
    
    res.c0.set_value(   res.fit_c0  , tag );
    
    for i=1:length(res.mode)
        if ~res.guess_mode(i)
            break
        end
    end
    
    res.r0.set_value(...
        1/(2*pi*mean(res.freq)*res.c0.value)/0.001,tag);

    res.rs.set_value(10,tag);
%     if isempty(res.mode)
%         res.add_mode;
%         res.guess_mode(1);
%     end
    res.set_default_boundaries;
    
end
