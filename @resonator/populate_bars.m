function populate_bars(r)
if isempty(r.boundaries_bars)
    r.setup_bars;
else
    if any(~isvalid(r.boundaries_bars))
        r.setup_bars;
    end
end


bars=r.boundaries_bars;

if length(bars)~=r.n_param
    r.setup_bars;
end
    for i=1:r.n_param
          [min,max] =   r.get_boundary(i);
          v         =   r.get_param(i);
          bars(i).Min = min;
          bars(i).Max = max;
          bars(i).Value = v;
    end
end
