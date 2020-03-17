function boundaries=set_boundaries(res)
    fprintf('\nSetting default boundaries.\n');
    boundaries=[];
    if isempty(res.y_meas)
        fprintf('Empty measure: No bounds generated\n');
        return;
    end

    freq    =   res.freq;
    boundaries.c0.min      =   res.c0*0.2;
    boundaries.c0.max      =   res.c0*5;
       
    for i=1:length(res.mode)
    
        boundaries.mode(i).q.min       =   0.01*...
                                            res.mode(i).q;
        boundaries.mode(i).q.max       =   100*...
                                            res.mode(i).q;

        boundaries.mode(i).kt2.min     =   0;
        boundaries.mode(i).kt2.max     =   1;

        boundaries.mode(i).fres.max    =   res.mode(i).fres/0.75;
        boundaries.mode(i).fres.min    =   res.mode(i).fres*0.75;
        
    end

    boundaries.r0.min      =   0.1*res.r0;
    boundaries.r0.max      =   10*res.r0;

    boundaries.rs.min      =   0.1*res.rs;
    boundaries.rs.max      =   10*res.rs;
    res.boundaries         =    boundaries;

end
