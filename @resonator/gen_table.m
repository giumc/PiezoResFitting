function tab=gen_table(r)
    
    tot_param=length(r.max_mode)+3;
    
    for i=1:tot_param
        if i<=r.n_param
            
            vars(i)=r.get_param(i).value;
            names(i)=r.get_param(i).label;

        else
            
            vars(i)=NaN;
            names(i)=r.get_param(i).label;
            
        end
    end
    
    if length(r.mode)<r.max_modes
    end

    tab=array2table(vars);
    tab.Properties.VariableNames=names;
    tab.Properties.RowNames=string(r.tag);
    tab.Properties.DimensionNames={'Resonator','Parameters'};
    r.data_table=tab;
end
