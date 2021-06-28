function dims=get_map_size(obj)
    
    tab=obj.layout_table;
    
    for i=1:height(tab)
        
        idx(i,:)=tab.MappingDim(i,:);
        
    end
    
    for i=1:obj.get_map_dims
        
        dims(i)=max(idx(:,i));
        
        if any(idx(:,i)==0)
            
            dims(i)=dims(i)+1;
            
        end
        
    end
    
end
    
    