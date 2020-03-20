function num=get_param(r,index)
    num=0;
    if ~isnumeric(index)||index<1
        fprintf('\nCannot get parameter.\n');
        return
    end
    
    switch index
        case 1
            num=r.c0.value;
        case 2
            num=r.r0.value;
        case 3
            num=r.rs.value;
        otherwise
            k=mod(index-1,3);
            n=floor((index-1)/3);
            switch k
                case 0
                    num=r.mode(n).fres.value;
                case 1
                    num=r.mode(n).q.value;
                case 2
                    num=r.mode(n).kt2.value;
            end
    end
            
end
