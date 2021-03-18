function tab=gen_table(r)
    
    tot_param=3*r.max_modes+3;
    vars=zeros(1,length(tot_param));
    names=repmat("",1,length(tot_param));
    for i=1:tot_param
        if i<=r.n_param
            
            vars(i)=r.get_param(i).value;
            names(i)=r.get_param(i).label;

        else
            
            vars(i)=NaN;
            names(i)=r.param_name(i);
            
        end
    end

    tab=array2table(vars);
    tab.Properties.VariableNames=names;
    tab.Properties.RowNames=string(r.tag);
    tab.Properties.DimensionNames={'Resonator','Parameters'};
    r.data_table=tab;
end