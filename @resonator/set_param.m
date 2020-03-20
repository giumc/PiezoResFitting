function set_param(r,index,value)

    if ~isnumeric(index)||~isnumeric(value)
        fprintf('\nCannot set parameter\n');
    end

    switch index
        case 1
            r.c0=value;
        case 2
            r.r0=value;
        case 3
            r.rs=value;
        otherwise
            k=mod(index-1,3);
            n=floor((index-1)/3);
            switch k
                case 0
                    r.mode(n).fres=value;
                case 1
                    r.mode(n).q=value;
                case 2
                    r.mode(n).kt2=value;
            end
    end
                    

end
