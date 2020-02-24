function y = error_function(res,x0)
    y=[];
    
    res.array_to_variables(x0);
    
    if isempty(res.y_meas) || isempty(res.y_calc)
        return;
    else
        
        mag_err     =   relative_error(@res.db,res);
        mag_phase   =   relative_error(@angle,res);
        
        y           =   ( mag_err + mag_phase ) ./ 2;
    end
    
    
    function y = relative_error(func,r)
        y = norm_error ( func, r) ;
        
        function y = norm_error(func,r)
            y = sum ( ...
                abs ( func( r.y_meas ) - func(r.y_calc) ) .^2  ...
                             ./ abs(func(r.y_meas)) )   ;
        end

        function y = max_error(func,r)
            y = max ( ...
                abs ( func( r.y_meas ) - func(r.y_calc) ) .^2 ) ;
        end
    end

end

% here we can cap the number of points if the code is too slow...


