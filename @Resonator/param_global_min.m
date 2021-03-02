function n= param_global_min(i)

param_min=[1e-15 0 0 0 0 0 ];

n=1;
switch i
    case {1, 2 ,3}
        n=param_min(i);
    otherwise
        index=mod(i-1,3);
        switch index
            case {0,1,2}
                n=param_min(i);
        end
end

end
