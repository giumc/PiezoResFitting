function y = error_function(res,varargin)

    %if array of normalized values is passed,
    %it is used to get error with resonator obtained with those 
    %new variables. 
    %(Functionality is necessary for optimization)
    
    if~isempty(varargin)
        
        res.transform_resonator(varargin{1});
        
    end
    
    y_meas =  res.y_smooth;
    y_calc =  res.get_y;
    freq   =  res.freq;
    
    if isempty(y_meas) || isempty(y_calc)
        
        fprintf('y_meas or y_calc is empty, abort\n');
        return;
        
    else

        angle_deg   =   @(x) 180/pi*angle(x);
        
        mag_err     =   norm_error(@(x) res.db(x));

        phase_err   =   norm_error(angle_deg);

        y           =   ( mag_err + phase_err ) ./ 2;
%         y=mag_err;
    end

    function y = norm_error(func)
        y = sum ( ...
            abs ( (func( y_meas)  - func(y_calc))) .^2 )./length(freq);
    end
end

% here we can cap the number of points if the code is too slow...


