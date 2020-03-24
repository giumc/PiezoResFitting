function guess_mode(r,i)
    y_meas =    r.y_smooth;
    freq    =   r.freq_smooth;
    
    tag = 'override'; % override previous values / bounds
    
    [~,i_max_1,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',max([1,length(r.mode)]));
    %for other modes, take peaks from dbcurve
    
    [~,i_max_2 ] = findpeaks(r.db(y_meas),...
            'SortStr','descend',...
            'MinPeakProminence',5,...
            'NPeaks',max([1,length(r.mode)]));
    i_max_1=i_max_1(1);
    i_max_2(1)=[];
    i_max=[i_max_1  i_max_2];
            
    [~,i_min] = findpeaks(r.db(1./y_meas),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);

    if i==1
        r.mode(i).fres.set_value(freq(i_max(i)),tag);

        r.mode(i).q.set_value(q(i) * ...
            (freq(2)-freq(1)),tag);

        r.mode(i).kt2.set_value(...
            r.calculate_kt2(...
            freq(i_max(1)),freq(i_min)),tag);
    else
        r.mode(i).fres.set_value(freq(i_max(i)),tag);

        r.mode(i).q.set_value(r.mode(i-1).q.value,tag);

        r.mode(i).kt2.set_value(r.mode(i-1).kt2.value,tag);
    end

    
end
