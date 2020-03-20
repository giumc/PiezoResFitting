function populate_labels(r)

    l=r.param_value_labels;
    
    if length(l)~=r.n_param
        r.setup_bars;
    end
    
    for i=1:length(l)
        
        [value_num,value_lab,~]=r.num2str_sci(r.get_param(i));
        l(i).String=strcat(sprintf('%.2f',value_num),value_lab);
        
    end
    
end

