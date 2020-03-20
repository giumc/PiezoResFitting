function edit_callback(src,~,res)
    if contains(src.Tag,'min')
        caller_type='min';
        tag=strrep(src.Tag,'min','');
    else
        if contains(src.Tag,'max')
            caller_type='max';
            tag=strrep(src.Tag,'max','');
        else
            return
        end
    end
        
    src_id=res.get_id_param(tag);
    res.set_boundary(src_id,res.str2num_sci(src.String),caller_type);
    res.populate_bars;
    res.populate_boundaries_edit;
end

