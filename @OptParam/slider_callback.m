function slider_callback(obj,src,event)

    obj.set_value(obj.denormalize(src.Value));
    notify(obj,'GraphicUpdate');
    
end
