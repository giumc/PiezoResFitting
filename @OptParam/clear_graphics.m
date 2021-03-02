function clear_graphics(obj)

    deleteobj(obj.slider);
    deleteobj(obj.min_label);
    deleteobj(obj.max_label);
    deleteobj(obj.name_label);
    deleteobj(obj.value_label);
    
    function deleteobj(x)
    
        if ~isempty(x)
            
            if isvalid(x)
                
                delete(x)
                
            end
            
        end
        
    end

end
