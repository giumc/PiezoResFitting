function Z0=get_Z0(obj)
     
    fcenter=obj.mode(1).fres.value;
    
    Z0=1/2/pi/fcenter/obj.c0.value;
    
end
    