function set_boundary(r,index,value,type)

    if index<=0 || ~isnumeric(value) || ~contains(type,{'min','max'})
        fprintf('\n Could not update boundaries.\n');
        return
    end
    
    switch index
        case 1
           if strcmp(type,'min')
            r.boundaries.c0.min=value;
            else
                if strcmp(type,'max')
                    r.boundaries.c0.max=value;
                end
            end
        case 2
            if strcmp(type,'min')
            r.boundaries.r0.min=value;
            else
                if strcmp(type,'max')
                    r.boundaries.r0.max=value;
                end
            end
        case 3
           if strcmp(type,'min')
            r.boundaries.rs.min=value;
            else
                if strcmp(type,'max')
                    r.boundaries.rs.max=value;
                end
            end

        otherwise
            k=mod(index-1,3);
            n=floor((index-1)/3);
            switch k
                case 0
                        if strcmp(type,'min')
                            r.boundaries.mode(n).fres.min=value;
                        else
                            if strcmp(type,'max')
                                r.boundaries.mode(n).fres.max=value;
                            end
                        end
                case 1                      
                    if strcmp(type,'min')
                            r.boundaries.mode(n).q.min=value;
                    else
                        if strcmp(type,'max')
                            r.boundaries.mode(n).q.max=value;
                        end
                    end
                case 2
                    if strcmp(type,'min')
                            r.boundaries.mode(n).kt2.min=value;
                    else
                        if strcmp(type,'max')
                            r.boundaries.mode(n).kt2.max=value;
                        end
                    end
            end
    end
    
end


    

