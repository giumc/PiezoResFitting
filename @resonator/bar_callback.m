function bar_callback(src,~,res)
    src_id=id_name(src.Tag);
    value=src.Value;
    switch src_id
        case -1
            return;
        case 1
            res.c0=value;
        case 2
            res.r0=value;
        case 3
            res.rs=value;
        otherwise
            n=floor((src_id-1)/3);
            index=mod(src_id-1,3);
            
            switch index
                case 0
                    res.mode(n).fres=value;
                case 1
                    res.mode(n).q=value;
                case 2
                    res.mode(n).kt2=value;
            end
                    
    end
    res.plot_data;
    res.table_res;
    
end

function index=id_name(name)
    index=0;
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
    
    if isnan(mode)||index==0
        index=-1;
        fprintf('\n Could not determine caller id.\n');
    else
        index=index+mode*3;
    end
end
