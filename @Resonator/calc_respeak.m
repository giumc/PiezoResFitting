function respeak=calc_respeak(obj)

    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth;
    
        [~,i,w,p]=findpeaks(obj.db(y_meas),...
        'MinPeakHeight',obj.y_peak_threshold_low,...
        'MinPeakWidth',1,...
        'MaxPeakWidth',length(freq),...
        'MinPeakProminence',obj.y_peak_threshold_prom);
    
    if isempty(i)
        
        error("device is not a resonator, there are no peaks");
        
    else
        
        %auxiliary findpeaks to find linear width
        [~,i_aux,w_aux,p_aux]=findpeaks(abs(y_meas).^2,...
        'MinPeakHeight',10^(obj.y_peak_threshold_low/10),...
        'MinPeakWidth',1,...
        'MaxPeakWidth',length(freq),...
        'MinPeakProminence',1e-8,...
        'WidthReference','halfheight');
    
        for k=1:length(w)
            
            flag(k)=false;
            
            for h=1:length(i_aux)
            
                if i_aux(h)==i(k)
                
                    w(k)=w_aux(h);
                    
                    flag(k)=true;
                
                end
                
            end

        end
        
        % if a mode is not in the auxiliary list, assume the worst case and
        % assign the lowest w 
        w_worst=max(w);
        
        for k=1:length(w)
            
            if flag(k)==false
                
                w(k)=w_worst;
                
            end
            
        end
    
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
        
    end

    obj.respeak=respeak;

end