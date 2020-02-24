function y = error_function(res,x0)
    y=[];
    
    res.array_to_variables(x0);
    
    if isempty(res.y_meas) || isempty(res.y_calc)
        return;
    else
        
        mag_err     =   norm_error(@res.db,res);
        mag_phase   =   norm_error(@angle,res);
        
        y           =   ( mag_err + mag_phase ) ./ 2;
    end
    
    

        
    function y = norm_error(func,r)
        y = sum ( ...
            abs ( func( r.y_meas ) - func(r.y_calc) ) .^2  )...
                         ./ length(r.freq)   ;
    end

    function y = max_error(func,r)
        y = max ( ...
            abs ( func( r.y_meas ) - func(r.y_calc) ) .^2 ) ;
    end

end

% here we can cap the number of points if the code is too slow...


