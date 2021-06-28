function dims=get_map_dims(obj)
   
    tab=obj.layout_table;
   
    dims=length(tab.MappingDim(1,:));
    
    for i=1:height(tab)
       
        if ~(dims==length(tab.MappingDim(i,:)))
            
            error(strcat(sprintf("Dimension of element n%d",i),...
                "is not uniform with preceding elements"));
            
        end
        
    end
end