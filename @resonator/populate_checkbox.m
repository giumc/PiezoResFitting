function populate_checkbox(r)
    drawnow;
checks=r.optim_checkbox;
for i=1:r.n_param
    opt_param=r.get_param(i);
    checks(i).Value=opt_param.optimizable;

end
end
