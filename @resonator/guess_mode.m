function flag=guess_mode(r,i)
    flag    =   true;
    
    freq    =   r.freq_smooth;
    
    y_meas  =   r.y_smooth; % to avoid noise
%     print(i)
    %calculate peaks from findpeaks function (if not already done)
    if isempty(r.respeak)
        
        respeak=struct('peak',0,'freq',0,'index',0,'prom',0);%'q',0
        
        [~,ilin,qlin,~] = findpeaks(abs(y_meas).^2,...
                    'WidthReference','halfheight');

        [ydb,idb,~,pdb] = findpeaks(r.db(y_meas),...
            'SortStr','descend','MinPeakHeight',-95,'MinPeakWidth',13);
        qeff=zeros(1,length(idb));
        
        for k=1:length(idb)
            x=find(ilin==idb(k));
            if length(x)>1
                x=x(1)
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
           
    [~,i_min] = findpeaks(r.db(1./y_meas),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);

    tag = 'override';
    df= (freq(2)-freq(1));
    if length(respeak)>=i
        
        if i==1
            r.mode(i).fres.set_value(respeak(i).freq,tag);

            r.mode(i).q.set_value(r.mode(i).fres.value/...
                respeak(i).q/df,tag);

            r.mode(i).kt2.set_value(...
                r.calculate_kt2(...
                respeak(i).freq,freq(i_min)),tag);
        else

            r.mode(i).fres.set_value(respeak(i).freq,tag);
%             r.mode(i).q.set_value(r.mode(i).fres.value/...
%                 respeak(i).q/df,tag);
            
        end
    else
        flag=false;
    end
            
end
