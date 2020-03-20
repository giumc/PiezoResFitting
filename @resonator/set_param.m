function set_param(r,index,value)

    if ~isnumeric(index)||~isnumeric(value)
        fprintf('\nCannot set parameter\n');
    end

    switch index
        case 1
            r.c0.set_value(value);
        case 2
            r.r0.set_value(value);
        case 3
            r.rs.set_value(value);
        otherwise
            k=mod(index-1,3);
            n=floor((index-1)/3);
            switch k
                case 0
                    r.mode(n).fres.set_value(value);
                case 1
                    r.mode(n).q.set_value(value);
                case 2
                    r.mode(n).kt2.set_value(value);
            end
    end
                    

end
