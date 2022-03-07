function respeak=calc_respeak(obj)

    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth; % to avoid noise
    
        [~,i,w,p]=findpeaks(abs(y_meas).^2,...
        'MinPeakHeight',1e-5,...
        'MinPeakWidth',1,...
        'MaxPeakWidth',length(freq),...
        'MinPeakProminence',1e-5);
    
    [~,s]=sort(p,"descend");

    i_sorted=i(s);

    [~,s]=sort(abs(i_sorted-i_sorted(1)),"ascend");

    i_sorted=i_sorted(s);

    w_sorted=w(s);
    
    p_sorted=p(s);

    for k=1:length(i_sorted)
    
        i_s=i_sorted(k);
        
        respeak(k).peak=20*log10(abs(y_meas(i_s))); %#ok<*AGROW>

        respeak(k).freq=freq(i_s);

        respeak(k).index=i_s;

        respeak(k).q=w_sorted(i_s);

        respeak(k).prom=p_sorted(i_s);

    end

    if length(respeak)>obj.max_modes

        respeak((obj.max_modes+1):end)=[];

    end

    obj.respeak=respeak;

end