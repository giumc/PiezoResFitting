function y = error_function(res,x0)
    y=[];
    res.array_to_variables(x0);
    y_meas =  res.y_smooth;
    y_calc =  res.y_calc;
    freq   =  res.freq;
    if isempty(y_meas) || isempty(y_calc)
        fprintf('y_meas or y_calc is empty, abort\n');
        return;
    else

        angle_deg   =   @(x) 180/pi*angle(x);
        mag_err     =   norm_error(@(x) res.db(x));

        phase_err   =   norm_error(angle_deg);

        y           =   ( mag_err + phase_err ) ./ 2;
    end

    function y = norm_error(func)
        y = sum ( ...
            abs ( (func( y_meas ) - func(y_calc))) .^2  )./length(freq);
    end
end

% here we can cap the number of points if the code is too slow...


