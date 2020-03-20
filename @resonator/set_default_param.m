function set_default_param(r)
    r.c0    =   1e-12;
    r.r0    =   1e4;
    r.rs    =   1; 
    
    for i=1:length(r.mode)
        r.mode(i).fres  =   1e9;
        r.mode(i).q     =   1e3;
        r.mode(i).kt2   =   0.03;
    end
end
