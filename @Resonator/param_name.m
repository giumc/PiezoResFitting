function name=param_name(k)
        
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
                    n=floor((k-1)/3);
                    index=mod(k-1,3);
                    switch index
                        case 0
                            name=strcat('Fres_',num2str(n));
                        case 1
                            name=strcat('Q_',num2str(n));
                        case 2
                            name=strcat('kt2_',num2str(n));
                    end
        end
        
     end
