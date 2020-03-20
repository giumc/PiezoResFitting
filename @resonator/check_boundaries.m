function check_boundaries(res)
%callback function, triggered when one attempts to modify boundaries

    for i=1:res.n_param
        [min,max]   =   res.get_boundary(i);
        v           =   res.get_param(i);
        
        %prevent weird cases
        if min > max
            res.set_boundary(i,max,'min');
        end
        if max < min
            res.set_boundary(i,min,'max');
        end
        
        %adjust 
        if v < min
            res.set_param(i,min);
        else
            if v > max
                res.set_param(i,max);
            end
        end
        
    end
    
    res.update_fig;
    
end
