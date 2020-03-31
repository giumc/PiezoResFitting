function populate_labels(r)

    
if isempty(r.param_value_labels)
    r.setup_bars;
else
    if any(~isvalid(r.param_value_labels))
        r.setup_bars;
    end
end

l=r.param_value_labels;
    
    for i=1:r.n_param
        name=r.param_name(i);
        opt_param=r.get_param(name);
        l(i).String=opt_param.convert2sci(opt_param.value);
    end
    
end

