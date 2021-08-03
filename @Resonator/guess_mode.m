function flag=guess_mode(obj,mode_index)

    flag    =   true;
    
    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth; % to avoid noise

    %calculate peaks from findpeaks function (if not already done)
    
    if isempty(obj.respeak)
        
        respeak=obj.calc_respeak;
        
    else
    
        respeak=obj.respeak;
        
    end
    
    if length(respeak)<mode_index
        
        flag=false;
        
        return
        
    end
    
    %filter around resonance
    freq_window_min=max([respeak(1).freq/1.5,min(freq)]);
    freq_window_max=min([respeak(1).freq*1.5,max(freq)]);
    freq_window_step=mean(diff(freq));
    
    freq_window=freq_window_min:freq_window_step:freq_window_max;
    
    for i=1:length(freq_window)
        
        [~,min_index]=min(abs(freq-freq_window(i)));
        y_window(i)=y_meas(min_index);
    
    end
    
    [~,i_min] = findpeaks(-obj.db(y_window),...
        'SortStr','descend',...
        'NPeaks',1);

    tag = 'override';
    
    df= (freq(2)-freq(1));
        
    fund_peak=respeak(1);
    
    this_peak=respeak(mode_index);
    
    this_mode=obj.mode(mode_index);
    
    if mode_index==1

        kt2_try=obj.calculate_kt2(...
            fund_peak.freq,freq_window(i_min));

        if isnan(kt2_try)

            warning(strcat("something went wrong with kt2 a-priori ",...
                "estimation, Setting kt2_1 to 1e-6"));

            kt2_try=1e-2;

        else

            if kt2_try<=0

                warning(strcat("kt2 estimated <0,\n",...
                    "Setting kt2_1 to 1e-6"));

                kt2_try=1e-2;

            end

        end

        this_mode.kt2.set_value(kt2_try,tag);

        this_mode.fres.set_value(this_peak.freq,tag);

        this_mode.q.set_value(this_peak.freq/...
           this_peak.q/df,tag);

    else

        previous_mode=obj.mode(mode_index-1);
        
        this_mode.fres.set_value(this_peak.freq,tag);
        
        this_mode.q.set_value(previous_mode.q.value,tag);

    end
       
end
