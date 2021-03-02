function update_graphics(obj)
   
    if ~isempty(obj.min_label)
        if isvalid(obj.min_label)
            
             obj.min_label.String=convert2sci(obj.min);
             
        end
    end
    
    if ~isempty(obj.max_label)
        if isvalid(obj.max_label)
            
            obj.max_label.String=convert2sci(obj.max);
            
        end
    end
    
    if ~isempty(obj.value_label)
         if isvalid(obj.value_label)
            
             obj.value_label.String=convert2sci(obj.value);
    
         end  
    end
           
    if ~isempty(obj.slider)
        if isvalid(obj.slider)
        
            obj.slider.Value=obj.normalize;
            
        end
    end
    
    drawnow;
    
end
