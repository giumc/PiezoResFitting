function [scaled_values,label,exp]=scale_magnitude(values)
    scaled_values=values;
    label='';
    exp=0;
    for i=-15:3:15 
        if mean(values)/10^(i) <= 1e3 && mean(values)/10^(i) > 1
            switch i
                case -15
                    label   =   'f';
                    break;
                case -12
                    label   =   'p';
                    break;
                case -9
                    label   =   'n';
                    break;
                case -6
                    label   =   'u';
                    break;
                case -3
                    label   =   'm';
                    break;
                case 0
                    label   =   '';
                    break;
                case 3
                    label   =   'K';
                    break;
                case 6
                    label   =   'M';
                    break;
                case 9
                    label   =   'G';
                    break;
                case 12
                    label   =   'T';
                    break;
            end
            break;
        end
    end
        scaled_values    =   values./10^(i); 
        exp = i;
end
