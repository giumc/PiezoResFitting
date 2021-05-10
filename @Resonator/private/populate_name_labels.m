function populate_name_labels(r)

    
    if isempty(r.param_value_labels)
        return
    else
        if any(~isvalid(r.param_value_labels))
            return
        end
    end

    if length(r.param_name_labels)~=r.n_param()
        
        r.setup_name_labels;

    end
    
end

