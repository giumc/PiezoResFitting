function add_mode(res)
    n_modes     =   length(res.mode);
    fprintf('Adding mode n %d\n',n_modes+1);
    res.mode(n_modes+1)=res.mode(n_modes);
    res.guess_coarse;
    res.boundaries.center_bound.mode(n_modes+1)=res.mode(n_modes+1);
    res.set_boundaries;
end
