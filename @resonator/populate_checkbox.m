function populate_checkbox(r)

    if any(isempty(r.optim_checkbox))
        return
    else
        if any(~isvalid(r.optim_checkbox))
            return
        end
    end
    
    if length(r.optim_checkbox)~=r.n_param()
        r.setup_optim_checkbox();
    end
    
    checks=r.optim_checkbox;
    for i=1:r.n_param
        opt_param=r.get_param(i);
        checks(i).Value=opt_param.optimizable;

    end

end
