function elem=get_map(obj)
    % returns a struct array with fields:
    %   position
    %   layout_param
    %   fit_param
    % position is a positional array (es [0 1] )
    % layout_param,fit_param are tables 
    
    fit_table=obj.fit_table;
    
    layout_table=obj.layout_table;
    
    for i=1:height(fit_table)
        
        elem(i).pos=fit_table.MappingDim(i,:);
        elem(i).layout_param=...
            layout_table(find(all(...
                layout_table.MappingDim(i,:)==elem(i).pos),1),:);
        elem(i).fit_param=fit_table(i,:);
        
    end
    
end