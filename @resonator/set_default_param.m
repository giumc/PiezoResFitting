function set_default_param(r)

    i=1;
    r.c0 = opt_param(100e-15);
    r.c0.label=r.get_param_name(i);
    r.c0.unit=r.get_unit(i);
    
    i=2;
    r.r0 = opt_param(100e3);
    r.r0.label=r.get_param_name(i);
    r.r0.unit=r.get_unit(i);
    
    i=3;
    r.rs = opt_param(1);
    r.rs.label=r.get_param_name(i);
    r.rs.unit=r.get_unit(i);
    
    i=4;
    r.mode.fres = opt_param(1e9);
    r.mode.fres.label=r.get_param_name(i);
    r.mode.fres.unit=r.get_unit(i);
    
    i=5;
    r.mode.q = opt_param(1e3);
    r.mode.q.label=r.get_param_name(i);
    r.mode.q.unit=r.get_unit(i);
    
    i=6;
    r.mode.kt2 = opt_param(0.1);
    r.mode.kt2.label=r.get_param_name(i);
    r.mode.kt2.unit=r.get_unit(i);
    
end
