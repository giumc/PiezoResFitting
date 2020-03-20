function set_max(opt_param,max)
%callback function, triggered when one attempts to modify boundaries
    
min=opt_param.min;
v=opt_param.value;

%prevent weird cases

if max < min
    opt_param.min=max;
    opt_param.value=max;
end

%adjust 

if v > max
    opt_param.value=max;
    opt_param.max=max;
else
    opt_param.max=max;
end

 
end
