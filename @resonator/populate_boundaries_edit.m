function populate_boundaries_edit(r)

    if length(r.boundaries_edit)~=r.n_param
        r.setup_bars;
    end
    
    for i=1:length(r.boundaries_edit)

        [min,max]   =   r.get_boundary(i);

        [scaled_min,min_label,~]=r.num2str_sci(min); 
        [scaled_max,max_label,~]=r.num2str_sci(max);


        edits=r.boundaries_edit{i};
        edits(1).String=strcat(...
            sprintf('%.1f%',scaled_min),'',...
            min_label);
        edits(2).String=strcat(...
            sprintf('%.1f%',scaled_max),'',...
         max_label);
    end
end
