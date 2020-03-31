function set_max(opt_param,local_max)
%callback function, triggered when one attempts to modify boundaries
    
local_min=opt_param.min;
v=opt_param.value;

%prevent weird cases
if local_max < local_min
    opt_param.min=local_max;
    opt_param.value=local_max;
end

if local_max > opt_param.global_max
    opt_param.max=opt_param.global_max;
end

%adjust

if v > local_max
    opt_param.value=local_max;
    opt_param.max=min([local_max opt_param.global_max]);
else
    opt_param.max=min([local_max opt_param.global_max]);
end

 
end
