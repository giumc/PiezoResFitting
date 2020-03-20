function index=get_id_param(name)
    index=0;
    mode=0;
    switch name
        case 'C0'
            index=1;
        case 'R0'
            index=2;
        case 'Rs'
            index=3;
        otherwise
            if contains(name,'Fres')
               mode=str2double(strrep(name,'Fres_',''));
               index=1;
            else
                if contains(name,'Q')
                    mode=str2double(strrep(name,'Q_',''));
                    index=2;
                else
                    if contains(name,'kt2')
                        mode=str2double(strrep(name,'kt2_',''));
                        index=3;
                    end
                end
            end
    end
    
    if index==0
        index=-1;
        fprintf('\n Could not determine caller id.\n');
    else
        index=index+mode*3;
    end
end
