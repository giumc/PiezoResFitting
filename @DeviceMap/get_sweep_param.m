function pars=get_sweep_param(obj,axis,label)

    % returns a struct with the values and indexes of a layout parameter 
    % along an axis. 
    % 
    % Parameters:
    % -----------
    %   axis 
    %       can be 1,2,...,n   
    %   label 
    %       has to be a string

    layout_table=obj.layout_table;
    
    pos=layout_table.MappingDim;
    
    pos_filt=pos(:,[1:(axis-1),(axis+1:end)]);
    
    start_index=min(pos_filt);
    
    pos_select=layout_table(pos_filt==start_index,:);
    
    pars.value=pos_select.(label);
    
    pars.index=pos_select.MappingDim;
    
end