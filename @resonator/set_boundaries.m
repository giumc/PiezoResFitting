function opt_boundaries=set_boundaries(res)
    opt_boundaries=[];
    if isempty(res.y_meas)
        return;
    else 
        y_meas =    res.y_smooth;
    end

    freq    =   res.freq;
    
    c0_init                    =   res.c0;
    opt_boundaries.c0.min      =   c0_init*0.2;
    opt_boundaries.c0.max      =   c0_init*5;

    opt_boundaries.fres.max    =   max(freq);
    opt_boundaries.fres.min    =   min(freq);

    opt_boundaries.q.min       =   100;
    opt_boundaries.q.max       =   10e3;
    
    if res.mode(1).q < opt_boundaries.q.min || res.mode(1).q > opt_boundaries.q.max
        opt_boundaries.q.min    =   res.mode(1).q*0.2;
        opt_boundaries.q.max    =   res.mode(1).q*5;
    end

        
    opt_boundaries.kt2.min     =   0;
    opt_boundaries.kt2.max     =   1;

    r0_init                    =   res.r0;
    opt_boundaries.r0.min      =   0.2*r0_init;
    opt_boundaries.r0.max      =   5*r0_init;

    opt_boundaries.rs.min      =   0.1;
    opt_boundaries.rs.max      =   100;

end