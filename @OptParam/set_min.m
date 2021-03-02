function set_min(obj,min_value,varargin)

    if ~isempty(varargin)
        
        if strcmp(varargin{:},'override')
            
            if min_value < obj.global_min
                
                obj.min=obj.global_min;
                
            else
                
                obj.min=min_value;
                
                return
                
            end
        
        end
        
    end
        
    max_value=obj.max;
    
    v=obj.value;

    %prevent weird cases

    if min_value > max_value
        
        obj.max=min_value;
        
        obj.value=min_value;
        
    end

    %adjust 
    
    if v < min_value 
        
        obj.value=min_value;
        
    end
        
    obj.min=max([min_value obj.global_min]);
 
end
