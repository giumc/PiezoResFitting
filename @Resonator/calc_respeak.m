function respeak=calc_respeak(obj)

    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth;
    
        [~,i,w,p]=findpeaks(abs(y_meas).^2,...
        'MinPeakHeight',1e-5,...
        'MinPeakWidth',1,...
        'MaxPeakWidth',length(freq),...
        'MinPeakProminence',1e-7);
    
    [~,s]=sort(p,"descend");

    f_sorted=freq(i(s));
    
    w_sorted=w(s);
    
    p_sorted=p(s);

    [~,s2]=sort(abs(f_sorted-f_sorted(1)),"ascend");
    
    f_sorted=f_sorted(s2);
    
    w_sorted=w_sorted(s2);
    
    p_sorted=p_sorted(s2);
    
    respeak(length(f_sorted))=struct('freq',[],'q',[],'prom',[]);

    for k=1:length(f_sorted)
    
        respeak(k).freq=f_sorted(k);

        respeak(k).q=w_sorted(k);

        respeak(k).prom=p_sorted(k);

    end

    if length(respeak)>obj.max_modes

        respeak((obj.max_modes+1):end)=[];

    end

    obj.respeak=respeak;

end