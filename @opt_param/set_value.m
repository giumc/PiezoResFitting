function set_value(obj,value,varargin)

min=obj.min;
max=obj.max;

    if value>obj.global_max
        value=obj.global_max;
        obj.max=obj.global_max;
    end
    
    if value<obj.global_min
        value=obj.global_min;
        obj.min=obj.global_min;
    end

    if value >= min && value <= max
        obj.value=value;
        [val_scaled,label,~]=obj.num2str_sci(value);
        
    else
        if isempty(varargin)
            fprintf('%s not set to %.2f, out of bounds\n',obj.label,value);
        else
            if strcmp(varargin{1},'override')
                
                obj.set_min(value/2);
                obj.set_max(value*2);
                obj.set_value(value);
                
            end
        end
            
    end

end
