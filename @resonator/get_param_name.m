function name=get_param_name(k)
        
        name=[];
        if ~isnumeric(k)||k<=0
            fprintf('\nCannot get param name.\n');
            return
        end
        switch k
                case 1
                    name='C0';
                case 2
                    name='R0';
                case 3
                    name='Rs';
            otherwise
                    n=mod(k-1,3);
                    switch n
                        case 0
                            name='Fres';
                        case 1
                            name='Q';
                        case 2
                            name='kt2';
                    end
        end
     end
