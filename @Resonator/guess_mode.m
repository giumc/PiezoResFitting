function flag=guess_mode(r,mode_index)

    flag    =   true;
    
    freq    =   r.freq_smooth;
    
    y_meas  =   r.y_smooth; % to avoid noise
    
    minwidth = ceil(0.5e-3*length(freq)); % filter noise peaks
    
    minheight = -100;
%     print(i)
    %calculate peaks from findpeaks function (if not already done)
    
    if isempty(r.respeak)
        
        respeak=struct('peak',0,'freq',0,'index',0,'prom',0);%'q',0
        
        [~,ilin,qlin,~] = findpeaks(abs(y_meas).^2,...
                    'WidthReference','halfheight');

        [ydb,idb,~,pdb] = findpeaks(r.db(y_meas),...
            'SortStr','descend',...
            'MinPeakHeight',minheight,...
            'MinPeakWidth',minwidth);
        
        qeff=zeros(1,length(idb));
        
        for k=1:length(idb)
            
            x=find(ilin==idb(k));
            
            if length(x)>1
                
                x=x(1);
                
            end
            
            qeff(k)=qlin(x);
            
        end
        
        if ~isempty(idb)
            
            for k=1:length(idb)
                
                respeak(k).peak=ydb(k);
                
                respeak(k).freq=freq(idb(k));
                
                respeak(k).index=idb(k);
                
                respeak(k).q=qeff(k);
                
                respeak(k).prom=pdb(k);
                
            end
            
        else
            
            flag=false;
            
            return
            
        end
        
        %sort struct by prominence
        [~,idx]=sort([respeak.prom],'descend');
        
        respeak=respeak(idx);
        
        %keep only max_modes
        
        if length(respeak)>r.max_modes
            
            respeak((r.max_modes+1):end)=[];
            
        end
        
%         %sort remaining by peak height
%         [~,idx]=sort([respeak.peak],'descend');
%         respeak=respeak(idx);

        r.respeak=respeak;
                
    else
        
        respeak=r.respeak;
        
    end
    
    %main_antiresonance
  
    %filter around resonance
    freq_window_min=max([respeak(1).freq/1.5,min(freq)]);
    freq_window_max=min([respeak(1).freq*1.5,max(freq)]);
    freq_window_step=mean(diff(freq));
    
    freq_window=freq_window_min:freq_window_step:freq_window_max;
    
    for i=1:length(freq_window)
        
        [~,min_index]=min(abs(freq-freq_window(i)));
        y_window(i)=y_meas(min_index);
    
    end
    
    [~,i_min] = findpeaks(-r.db(y_window),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);

    tag = 'override';
    
    df= (freq(2)-freq(1));
    
    if length(respeak)>=mode_index
        
        if mode_index==1
            
            kt2_try=r.calculate_kt2(...
                respeak(mode_index).freq,freq_window(i_min));
            
            if isnan(kt2_try)
                
                warning(strcat("something went wrong with kt2 a-priori ",...
                    "estimation,\n Setting kt2_1 to 1e-6"));
                
                kt2_try=1e-2;
                
            else
            
                if kt2_try<=0

                    peak_tmp=respeak(mode_index);
                    
                    if mode_index==length(respeak)
                        
                        flag=false;
                        
                        return
                        
                    end
                        
                    respeak(mode_index)=respeak(mode_index+1);
                    respeak(mode_index+1)=peak_tmp;
                    
                        kt2_try=r.calculate_kt2(...
                    respeak(mode_index).freq,freq_window(i_min));
                
                        if kt2_try<=0

                            warning(strcat("kt2 estimated <0,\n",...
                                "Setting kt2_1 to 1e-6"));

                            kt2_try=1e-2;
                            
                        end

                end
                
            end
                
            r.mode(mode_index).kt2.set_value(kt2_try,tag);
            
            r.mode(mode_index).fres.set_value(respeak(mode_index).freq,tag);

            r.mode(mode_index).q.set_value(r.mode(mode_index).fres.value/...
                respeak(mode_index).q/df,tag);
           
        else

            r.mode(mode_index).fres.set_value(respeak(mode_index).freq,tag);
            
        end
        
    else
        
        flag=false;
        
    end
    
end
