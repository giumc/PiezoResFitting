function n= param_global_max(i)

param_max=[1e-3 1e12 1e6 1e12 1e9 1 ];

n=1;
switch i
    case {1, 2 ,3}
        n=param_max(i);
    otherwise
        index=mod(i-1,3);
        switch index
            case {0, 1, 2}
                n=param_max(i);
        end
end

end
