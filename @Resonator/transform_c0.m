function new_res=transform_c0(obj,c0_new)
    
    new_res=copy(obj);
    new_res.c0.set_value(c0_new,'override');

end