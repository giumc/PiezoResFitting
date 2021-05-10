function num=get_param(r,tag)
    index=[];
    
    if ischar(tag)||isstring(tag)
        for i=1:r.n_param
            names{i}=r.param_name(i);
            if strcmp(names{i},tag)
                index=i;
                break
            end
        end
    else
        if isnumeric(tag)
            if tag>0
                index=tag;
            end
        end
    end
    
    if isempty(index)
        fprintf('\nCannot get parameter.\n');
        return
    end
    
    switch index
        case 1
            num=r.c0;
        case 2
            num=r.r0;
        case 3
            num=r.rs;
        otherwise
            k=mod(index-1,3);
            n=floor((index-1)/3);
            switch k
                case 0
                    num=r.mode(n).fres;
                case 1
                    num=r.mode(n).q;
                case 2
                    num=r.mode(n).kt2;
            end
    end
            
end
