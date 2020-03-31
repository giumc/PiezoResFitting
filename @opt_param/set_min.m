function set_min(opt_param,min)
%callback function, triggered when one attempts to modify boundaries
    
max=opt_param.max;
v=opt_param.value;

%prevent weird cases

if min < opt_param.global_min
    opt_param.min=opt_param.global_min;
end
if min > max
    opt_param.max=min;
    opt_param.value=min;
end

%adjust 
if v < min 
    opt_param.value=min;
    opt_param.min=min;
else
    opt_param.min=min;
end
 
end
