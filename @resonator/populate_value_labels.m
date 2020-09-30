function populate_value_labels(r)

    
    if isempty(r.param_value_labels)
        return
    else
        if any(~isvalid(r.param_value_labels))
            return
        end
    end

    if length(r.param_value_labels)~=r.n_param()
        r.setup_value_labels;
    end
    
    l=r.param_value_labels;
    
    for i=1:r.n_param
        name=r.param_name(i);
        opt_param=r.get_param(name);
        l(i).String=convert2sci(opt_param.value);
    end
    
end

