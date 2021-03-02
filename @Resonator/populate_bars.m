function populate_bars(r)

if isempty(r.boundaries_bars)
    return
else
    if any(~isvalid(r.boundaries_bars))
        return
    end
end

if length(r.boundaries_bars)~=r.n_param()
    r.setup_bars();
end

bars=r.boundaries_bars;

if length(bars)~=r.n_param
    r.setup_bars;
end
    for i=1:r.n_param
        
        name=r.param_name(i);
        opt_param=r.get_param(name);

        bars(i).Min = opt_param.min;
        bars(i).Max = opt_param.max;
        bars(i).Value = opt_param.value;
    end
end
