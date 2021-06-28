function tab= read_table(obj,path)
    
    try
        
        tab=readtable(path);
            
    catch ME
        
        error(sprintf("Could not read %s with readtable()",path));
        
    end
    
    tab.Properties.VariableNames{1}='MappingTag';
        
    for i=1:height(tab)
        
        MappingDim(i,:)=obj.str2index(cell2mat(tab{i,1}));
        
    end
    
    tab=[table(MappingDim),tab];
    
end
