function guess_coarse(res)

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
    %from first mode, take peak from lincurve
    %so to get also q
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
    
    tag = 'override'; % override previous values / bounds
    
    res.c0.set_value(   res.fit_c0  , tag );

            for i=1:length(i_max)
                if i==1
                    res.mode(i).fres.set_value(freq(i_max(i)),tag);

                    res.mode(i).q.set_value(q(i) * ...
                        (freq(2)-freq(1)),tag);

                    res.mode(i).kt2.set_value(...
                        res.calculate_kt2(...
                        freq(i_max(1)),freq(i_min)),tag);
                else
                    res.mode(i).fres.set_value(freq(i_max(i)),tag);

                    res.mode(i).q.set_value(1000,tag);

                    res.mode(i).kt2.set_value(res.mode(1).kt2.value/10,tag);
                end
            end
            
    res.r0.set_value(...
        1/(2*pi*res.mode(1).fres.value*res.c0.value)/0.01,tag);

    res.rs.set_value(1);
    
    res.set_default_boundaries;
    
end
