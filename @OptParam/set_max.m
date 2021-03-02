function set_max(obj,max_value,varargin)
%callback function, triggered when one attempts to modify boundaries
    
    if ~isempty(varargin)

        if strcmp(varargin{:},'override')

            if max_value > obj.global_max

                obj.max=obj.global_max;

            else

                obj.max=max_value;

                return

            end

        end

    end

    min_value=obj.min;
    
    v=obj.value;

    %prevent weird cases
    if max_value < min_value
        
        obj.min=max_value;
        
        obj.value=max_value;
        
    end

    if max_value > obj.global_max
        
        obj.max=obj.global_max;
        
    end

    %adjust

    if v > max_value
        
        obj.value=max_value;
        
    end
        
    obj.max=min([max_value obj.global_max]);
    
end
