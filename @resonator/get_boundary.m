function [min,max]=get_boundary(r,i)
min=0;
max=1;
if ~isnumeric(i)||i<=0
    fprintf('\nCannot get boundary.\n');
    return
end

opt_param=r.get_param(i);
min=opt_param.min;
max=opt_param.max;

end
