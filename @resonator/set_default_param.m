function set_default_param(r)

    i=1;
    r.c0 = opt_param(100e-15);
    r.c0.label=r.param_name(i);
    r.c0.unit=r.param_unit(i);
    r.c0.global_min=r.param_global_min(i);
    r.c0.global_max=r.param_global_max(i);
    i=2;
    r.r0 = opt_param(100e3);
    r.r0.label=r.param_name(i);
    r.r0.unit=r.param_unit(i);
    r.r0.global_min=r.param_global_min(i);
    r.r0.global_max=r.param_global_max(i);
    i=3;
    r.rs = opt_param(1);
    r.rs.label=r.param_name(i);
    r.rs.unit=r.param_unit(i);
    r.rs.global_min=r.param_global_min(i);
    r.rs.global_max=r.param_global_max(i);
    
    for k=1:length(r.mode)
        i=4;
        r.mode(k).fres = opt_param(1e9);
        r.mode(k).fres.label=r.param_name(i);
        r.mode(k).fres.unit=r.param_unit(i);
        r.mode(k).fres.global_min=r.param_global_min(i);
        r.mode(k).fres.global_max=r.param_global_max(i);
        i=5;
        r.mode(k).q = opt_param(1e3);
        r.mode(k).q.label=r.param_name(i);
        r.mode(k).q.unit=r.param_unit(i);
        r.mode(k).q.global_min=r.param_global_min(i);
        r.mode(k).q.global_max=r.param_global_max(i);
        i=6;
        r.mode(k).kt2 = opt_param(0.1);
        r.mode(k).kt2.label=r.param_name(i);
        r.mode(k).kt2.unit=r.param_unit(i);
        r.mode(k).kt2.global_min=r.param_global_min(i);
        r.mode(k).kt2.global_max=r.param_global_max(i);
    end
    
end
