function respeak=calc_respeak2(obj)

    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth; % to avoid noise
    
    minwidth = 3; % filter noise peaks
    
    minheight = -100;
    
    gd_meas = -gradient(phase(y_meas));
    
    [~,i_gd]=findpeaks(gd_meas,...
            'MinPeakWidth',1,...
            'MinPeakProminence',0.5);

    for i=1:length(i_gd)
        
        i_m=i_gd(i);
        
        respeak(i).peak=obj.db(y_meas(i_m));
        respeak(i).freq=freq(i_m);
        respeak(i).index=i_m;
        respeak(i).q=2;
        
    end
    
    [~,idx]=sort([respeak.peak],'descend');
    respeak=respeak(idx);
    
    [~,idx]=sort(abs([respeak.freq]-respeak(1).freq),'ascend');
    respeak=respeak(idx);

end