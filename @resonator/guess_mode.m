function guess_mode(r,i)
    
    if isempty(res.y_meas)
        fprintf('No measured SParam was found,so no coarse fitting can be generated\n');
        return;
    else
        
        y_meas =    res.y_smooth;
    end
    
    if isempty(res.mode)
        fprintf('The resonator has no modes, use set_number_modes(X) method to add one\n');
        return
    end

    freq    =   res.freq;
    
    [~,i_max_1,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',max([1,length(res.mode)]));
    %for other modes, take peaks from dbcurve
    
    [~,i_max_2 ] = findpeaks(res.db(y_meas),...
            'SortStr','descend',...
            'MinPeakProminence',5,...
            'NPeaks',max([1,length(res.mode)]));
    i_max_1=i_max_1(1);
    i_max_2(1)=[];
    i_max=[i_max_1; i_max_2];
            
    [~,i_min] = findpeaks(res.db(1./y_meas),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);

    if i==1
        res.mode(i).fres.set_value(freq(i_max(i)),tag);

        res.mode(i).q.set_value(q(i) * ...
            (freq(2)-freq(1)),tag);

        res.mode(i).kt2.set_value(...
            res.calculate_kt2(...
            freq(i_max(1)),freq(i_min)),tag);
    else
        res.mode(i).fres.set_value(freq(i_max(i)),tag);

        res.mode(i).q.set_value(res.mode(i-1).q.value,tag);

        res.mode(i).kt2.set_value(res.mode(i-1).kt2.value,tag);
    end

    
end
