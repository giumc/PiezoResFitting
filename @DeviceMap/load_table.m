function load_table(obj,path)

    try
        
        tab=readtable(path);
            
    catch ME
        
        error(sprintf("Could not read %s with readtable()",path));
        
    end
    
    tab.Properties.VariableNames{1}='MappingTag';
        
    for i=1:height(tab)
        
        MappingDim(i,:)=obj.str2index(cell2mat(tab{i,1}));
        
    end
    
    data_table=[table(MappingDim),tab];
    
    if isempty(obj.data_table)
        
       obj.data_table=data_table;
       
    else
        
        new_data=data_table;
        
        old_data=obj.data_table;
         
        for i=1:height(new_data)
            
            idx=obj.str2index(cell2mat(new_data.MappingTag(i)));
            
            try
                
                match=find(all((old_data.MappingDim==idx).'), 1);
             
            catch ME 
                
                msg=strcat("Error when catenating tables",...
                    sprintf("\nElement %d in new table has a MappingDim %f",i),...
                    " that doesn't match any MappingDim in existing table");
                
                error(msg);
                
            end
                
            if i==1
                
                tot_data=[old_data(match,:),new_data(i,3:end)];
            else
                
                tot_data=[tot_data;[old_data(match,:),new_data(i,3:end)]];
                
            end
            
        end
        
        obj.data_table=tot_data;
        
    end
            
            
end