function guess_coarse(res)
    
    if isempty(res.y_meas)
        return;
    else 
        y_meas =    res.y_smooth;
    end

    freq    =   res.freq;
    
    [~,i_max,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',1);
            
    [~,i_min] = findpeaks(abs(1./y_meas).^2,...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);
    
            res.c0  =   res.fit_c0;
            res.init_fit.c0         =   res.c0;
            
            res.mode(1).fres    =   freq(i_max);
            res.init_fit.fres       =   res.mode(1).fres;
            
            res.mode(1).q       =   q * (freq(2)-freq(1));
            res.init_fit.q          =   res.mode(1).q;
            
            res.mode(1).kt2     =   res.calculate_kt2(freq(i_max),freq(i_min));
            
            res.r0              =   1./ (2*pi*res.mode(1).fres*res.c0) / 0.01;
            res.rs              =   1;
            
end
