function flag=guess_mode(r,i)
    flag    =   true;
    
    freq    =   r.freq_smooth;
    
    y_meas  =   r.y_smooth; % to avoid noise
%     print(i)
    %calculate peaks from findpeaks function (if not already done)
    if isempty(r.respeak)
        
        respeak=struct('peak',0,'freq',0,'index',0,'q',0,'prom',0);
        
        [~,ilin,qlin,~] = findpeaks(abs(y_meas).^2,...
                    'WidthReference','halfheight',...
                    'SortStr','descend');
%         keyboard()
        [ydb,~,~,pdb] = findpeaks(r.db(y_meas),...
            'SortStr','descend');
               
        for k=1:length(ilin)
            respeak(k).peak=ydb(k);
            respeak(k).freq=freq(ilin(k));
            respeak(k).index=ilin(k);
            respeak(k).q=qlin(k);
            respeak(k).prom=pdb(k);
        end
        
        %sort struct by prominence
        [~,idx]=sort([respeak.prom],'descend');
        respeak=respeak(idx);
        
        %remove noisy peaks
        respeak([respeak.peak]<-95)=[];
        
        %keep only max_modes
        if length(respeak)>r.max_modes
            respeak((r.max_modes+1):end)=[];
        end
        
        %sort remaining by peak height
        [~,idx]=sort([respeak.peak],'descend');
        respeak=respeak(idx);
        r.respeak=respeak;
        
    else
        
        respeak=r.respeak;
        
    end
            
    [~,i_min] = findpeaks(r.db(1./y_meas),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);

    tag = 'override'; 
    if i==1
        r.mode(i).fres.set_value(respeak(i).freq,tag);

        r.mode(i).q.set_value(r.mode(i).fres.value/...
            (respeak(i).q*(freq(2)-freq(1))),tag);

        r.mode(i).kt2.set_value(...
            r.calculate_kt2(...
            respeak(i).freq,freq(i_min)),tag);
    else
        if length(respeak)>=i
            
            r.mode(i).fres.set_value(respeak(i).freq,tag);
        else
            flag=false;
        end
            
    end

    
end
