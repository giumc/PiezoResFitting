function x = error_function(res)
    x=[];

    if isempty(res.y_meas) || isempty(res.y_calc)
        return;
    else
        
        mag_err     =   relative_error(@res.db,res);
        mag_phase   =   relative_error(@angle,res);
        
        x           =   ( mag_err + mag_phase ) ./ 2;
    end
    
    
    function y = relative_error(func,r)
        y = norm_error ( func, r) ./ max_error(func,r );
        
        function y = norm_error(func,r)
            y = sum ( ...
                abs ( func( r.y_meas ) - func(r.y_calc) ) .^2 ) ...
                             ./ length (r.freq)  ;
        end

        function y = max_error(func,r)
            y = max ( ...
                abs ( func( r.y_meas ) - func(r.y_calc) ) .^2 ) ;
        end
    end

end

% here we can cap the number of points if the code is too slow...


