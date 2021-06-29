function pars=get_sweep_param(obj,axis,label)

    layout_table=obj.layout_table;
    
    pos=layout_table.MappingDim;
    
    pos_filt=pos(:,[1:(axis-1),(axis+1:end)]);
    
    start_index=min(pos_filt);
    
    pos_select=layout_table(pos_filt==start_index,:);
    
    pars.value=pos_select.(label);
    
    pars.index=pos_select.MappingDim;
end