function plot_data(r)

    
    fit_name='Fit';
    meas_name='Meas';
   
    freq     =   r.freq_smooth;
    
    y_meas  =   r.y_smooth;
    
    y_calc  =   r.get_y;

    if isempty(r.mag_axis)||isempty(r.phase_axis)
        
        return
        
    else
        
        if ~isvalid(r.mag_axis)||(~isvalid(r.phase_axis))
            
            return
            
        end
        
    end

    mag_axis    =   r.mag_axis;
    phase_axis  =   r.phase_axis;

    delete(mag_axis.Children);
    
    delete(phase_axis.Children);
    
    [freq,scale] =  num2str_sci(freq);
    
    freq_label  =   strcat('Frequency',{' ['},scale,{'Hz]'});
    
    phase_axis.XLabel.String=freq_label;
    
    mag_axis.XLabel.String=freq_label;

    mag_axis.NextPlot='replacechildren';
    
    phase_axis.NextPlot='replacechildren';
    
    if ~isempty(y_calc)
        
        p(1)=plot(mag_axis,freq,r.db(y_calc));
        
        p(1).DisplayName=fit_name;
        
        mag_axis.NextPlot='add';
        
        p(2)=plot(phase_axis,freq,180/pi*angle(y_calc));
        
        p(2).DisplayName=fit_name;
        
        phase_axis.NextPlot='add';  
        
    end
    
    if ~isempty(y_meas) 
        
        p(3)=plot(mag_axis,freq,r.db(y_meas));
        
        p(3).DisplayName=meas_name;
        
        mag_axis.NextPlot='add';
        
        p(4)=plot(phase_axis,freq,180/pi*angle(y_meas));
        
        p(4).DisplayName=meas_name;
        
        phase_axis.NextPlot='add';  
        
    end
   
    %adjust plots
    for i=1:length(p)
        
        p(i).LineWidth=1.5;
        
        p(i).Marker='none';
        
    end
    
    uistack(p(1));
    
    uistack(p(2));
    
    %adjust axis lim
    mag_axis.XLim   =   [min(freq) max(freq)];
    
    xticks_raw=linspace(min(freq),max(freq),11);
    
    for i=1:length(xticks_raw)
        
        xticks(i)=sprintf("%.1f",xticks_raw(i));
        
    end
    
    mag_axis.XTick= xticks_raw;
    
    mag_axis.XTickLabel  =   xticks;
    
    phase_axis.XLim =   mag_axis.XLim;
    
    phase_axis.XTick =   mag_axis.XTick;
    
    phase_axis.XTickLabel = mag_axis.XTick; 
    
    if isempty(y_meas)
        
        ymag_min        =   floor((min(r.db(y_calc))-10)/10)*10;
        
        ymag_max        =   ceil((max(r.db(y_calc))+10)/10)*10;
        
    else
        
        ymag_min        =   floor((min(r.db(y_meas))-10)/10)*10;
        
        ymag_max        =   ceil((max(r.db(y_meas))+10)/10)*10;
        
    end
    
    mag_axis.YLim       = [ymag_min ymag_max];
    
    mag_axis.YTick      = linspace(ymag_min,ymag_max,11);
    
    phase_axis.YLim     = [-95 95];
    
    phase_axis.YTick    = -90:30:90;
    
    %adjust grid
    
    mag_axis.XGrid      = 'on';
    
    mag_axis.YGrid      = 'on';
    
    phase_axis.XGrid    = 'on';
    
    phase_axis.YGrid    = 'on';
    
end
   
