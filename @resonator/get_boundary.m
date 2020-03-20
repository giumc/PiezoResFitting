function [min,max]=get_boundary(r,i)
min=0;
max=1;
if ~isnumeric(i)||i<=0
    fprintf('\nCannot get boundary.\n');
    return
end
    switch i 
        case 1
            min=r.c0.min;
            max=r.c0.max;
        case 2
            min=r.r0.min;
            max=r.r0.max;
        case 3
            min=r.rs.min;
            max=r.rs.max;

        otherwise
            index=mod(i-1,3);
            n=floor((i-1)/3);
            boundmode=r.mode(n);
            mode=r.mode(n);
            
            switch index
                case 0
                    min=boundmode.fres.min;
                    max=boundmode.fres.max;
                case 1
                    min=boundmode.q.min;
                    max=boundmode.q.max;
                case 2
                    min=boundmode.kt2.min;
                    max=boundmode.kt2.max;
            end
    end
