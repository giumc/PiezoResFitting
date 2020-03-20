function set_value(obj,value)

min=obj.min;
max=obj.max;

if value >= min && value <= max
    obj.value=value;
    [val_scaled,label,~]=obj.num2str_sci;
    obj.str_sci=strcat(...
        sprintf('%.2f',val_scaled),...
        label);
    obj.prefix=label;
else
    fprintf('%s not set to %.2f, out of bounds\n',obj.label,value);
    
end
end
