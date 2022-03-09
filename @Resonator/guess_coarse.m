function guess_coarse(obj)

    
    tag = 'override'; % override previous values / bounds
    
    obj.fit_c0;
    
    for i=1:length(obj.mode)
        if ~obj.guess_mode(i)
            break
        end
    end
    
    obj.r0.set_value(...
        5,tag);

    obj.rs.set_value(5,tag);
%     if isempty(obj.mode)
%         obj.add_mode;
%         obj.guess_mode(1);
%     end
    obj.set_default_boundaries;
    
end
