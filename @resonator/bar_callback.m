function bar_callback(src,~,res)
    
    value=src.Value;
    res.set_param(res.get_param(src.Tag),value);
    res.update_fig;
end

