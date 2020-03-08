function boundaries=set_boundaries(res)
    boundaries=[];
    if isempty(res.y_meas)
        return;
    end

    freq    =   res.freq;
    
    if isempty (boundaries)
        boundaries.center_bound   = struct();
        boundaries.center_bound.c0     =   res.c0;
        boundaries.center_bound.r0     =   res.r0;
        boundaries.center_bound.rs     =   res.rs;
        boundaries.center_bound.mode   =   res.mode;
    end
    
    c0_init                    =   boundaries.center_bound.c0;
    boundaries.c0.min      =   c0_init*0.2;
    boundaries.c0.max      =   c0_init*5;
       
    for i=1:length(res.mode)
    
        boundaries.mode(i).q.min       =   0.01*...
                                        boundaries.center_bound.mode(i).q;
        boundaries.mode(i).q.max       =   100*...
                                        boundaries.center_bound.mode(i).q;

        boundaries.mode(i).kt2.min     =   0;
        boundaries.mode(i).kt2.max     =   1;

        boundaries.mode(i).fres.max    =   max(freq);
        boundaries.mode(i).fres.min    =   min(freq);
        
    end

    r0_init                    =   boundaries.center_bound.r0;
    boundaries.r0.min      =   0.1*r0_init;
    boundaries.r0.max      =   10*r0_init;

    rs_init                    =   boundaries.center_bound.rs;
    boundaries.rs.min      =   0.1*rs_init;
    boundaries.rs.max      =   10*rs_init;
    res.boundaries         =    boundaries;

end
