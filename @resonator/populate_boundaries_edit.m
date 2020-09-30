function populate_boundaries_edit(r)

if isempty(r.boundaries_edit)
    return
else
    if any(~isvalid([r.boundaries_edit{:}]))
        return
    end
end
if length(r.boundaries_edit)~=r.n_param()
    r.setup_boundaries_edit
end
    for i=1:length(r.boundaries_edit)

        name=r.param_name(i);
        opt_param=r.get_param(name);

        edits=r.boundaries_edit{i};
        
        edits(1).String=convert2sci(opt_param.min);
        edits(2).String=convert2sci(opt_param.max);
        
    end
end
