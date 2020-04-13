function tab=gen_table(r)
    for i=1:r.n_param
       vars(i)=r.get_param(i).value;
       names(i)=r.get_param(i).label;
    end

    tab=array2table(vars);
    tab.Properties.VariableNames=names;
    tab.Properties.RowNames=string(r.tag);
    tab.Properties.DimensionNames={'Resonator','Parameters'};
    r.data_table=tab;
end
