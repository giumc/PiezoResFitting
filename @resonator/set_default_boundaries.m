function set_default_boundaries(res)
    %fprintf('\nSetting default boundaries.\n');
    boundaries=[];
    if isempty(res.y_meas)
        fprintf('Empty measure: No bounds generated\n');
        return;
    end
    
    boundaries.c0.min      =   res.c0*0.2;
    boundaries.c0.max      =   res.c0*5;
    
    boundaries.r0.min      =   0.1*res.r0;
    boundaries.r0.max      =   10*res.r0;

    boundaries.rs.min      =   0.1*res.rs;
    boundaries.rs.max      =   10*res.rs;
       
    for i=1:length(res.mode)
    
        boundaries.mode(i).q.min       =   0.2*...
                                            res.mode(i).q;
        boundaries.mode(i).q.max       =   5*...
                                            res.mode(i).q;

        boundaries.mode(i).kt2.min     =   0.5*...
                                            res.mode(i).kt2;
        boundaries.mode(i).kt2.max     =   2*...
                                            res.mode(i).kt2;

        boundaries.mode(i).fres.min    =   0.75*...
                                            res.mode(i).fres;
        boundaries.mode(i).fres.max    =   1.5*...
                                            res.mode(i).fres;
       
    end

    res.boundaries         =    boundaries;
    clc;
end
