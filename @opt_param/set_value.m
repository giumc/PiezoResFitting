function set_value(obj,value,varargin)

min=obj.min;
max=obj.max;


    if value >= min && value <= max
        obj.value=value;
        [val_scaled,label,~]=obj.num2str_sci(value);
        
    else
        if isempty(varargin)
            fprintf('%s not set to %.2f, out of bounds\n',obj.label,value);
        else
            if strcmp(varargin{1},'override')
                obj.min=value/2;
                obj.max=value*2;
                obj.set_value(value);
            end
        end
            
    end

end
