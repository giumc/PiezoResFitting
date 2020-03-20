function bar_callback(src,~,res)
    src_id=res.get_id_param(src.Tag);
    value=src.Value;
    res.set_param(src_id,value);
    res.update_fig;
end

