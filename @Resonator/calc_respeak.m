function respeak=calc_respeak(obj)

    freq    =   obj.freq_smooth;
    
    y_meas  =   obj.y_smooth; % to avoid noise
    
    minwidth = 2; % filter noise peaks
    
    minheight = -100;
    
    respeak=struct('peak',0,'freq',0,'index',0,'prom',0);%'q',0

    [~,ilin,qlin,~] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight');

    [ydb,idb,~,pdb] = findpeaks(obj.db(y_meas),...
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
%     [~,idx]=sort([respeak.prom],'descend');
    [~,idx]=sort(abs([respeak.freq]-respeak(1).freq),'ascend');

    respeak=respeak(idx);

    %keep only max_modes

    if length(respeak)>obj.max_modes

        respeak((obj.max_modes+1):end)=[];

    end

%         %sort remaining by peak height
%         [~,idx]=sort([respeak.peak],'descend');
%         respeak=respeak(idx);

    obj.respeak=respeak;

end