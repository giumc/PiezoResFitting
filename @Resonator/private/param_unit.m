function name=get_unit(index)
    name='';
    switch index
        case 1
            name='F';
        case 2
            name='Ohm';
        case 3
            name='Ohm';
        otherwise
            k=mod(index-1,3);
            switch k
                case 0
                    name='Hz';
                case 1
                    name='';
                case 2
                    name='';
            end
    end
end
