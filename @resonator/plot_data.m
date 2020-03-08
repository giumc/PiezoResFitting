function plot_data(r)


fit_name='Fit';
meas_name='Meas';

freq    =   r.freq;

y_calc  =   r.y_calc; 

y_meas  =   r.y_smooth;


if isempty(r.figure)
    r.setup_plot;
else
    if isobject(r.figure)
        if ~isvalid(r.figure)
            r.setup_plot;
        end
    end
end

mag_axis    =   r.mag_axis;
phase_axis  =   r.phase_axis;


    [freq,scale] =  r.scale_magnitude(freq);
    freq_label  =   strcat('Frequency',{' ['},scale,{'Hz]'});

    phase_axis.XLabel.String=freq_label;
    mag_axis.XLabel.String=freq_label;
%% populate plots

    mag_axis.NextPlot='replacechildren';
    phase_axis.NextPlot='replacechildren';
    
    if ~isempty(y_calc)
        p1=plot(mag_axis,freq,r.db(y_calc));
        p1.DisplayName=fit_name;
        mag_axis.NextPlot='add';
        p2=plot(phase_axis,freq,180/pi*angle(y_calc));
        p2.DisplayName=fit_name;
        phase_axis.NextPlot='add';       
    end
    
    if ~isempty(y_meas)
        p3=plot(mag_axis,freq,r.db(y_meas));
        p3.DisplayName=meas_name;
        mag_axis.NextPlot='add';
        p4=plot(phase_axis,freq,180/pi*angle(y_meas));
        p4.DisplayName=meas_name;
        phase_axis.NextPlot='add';
    end
    
    %adjust axis lim
    mag_axis.XLim   =   [min(freq) max(freq)];
    mag_axis.XTick  =   [min(freq):(max(freq)-min(freq))/10:max(freq)];   
    phase_axis.XLim =   mag_axis.XLim;
    phase_axis.XTick=   mag_axis.XTick;
    
    if isempty(y_meas)
        ymag_min        =   floor((min(r.db(y_calc))-10)/10)*10;
        ymag_max        =   ceil((max(r.db(y_calc))+10)/10)*10;
    else
        ymag_min        =   floor((min(r.db(y_meas))-10)/10)*10;
        ymag_max        =   ceil((max(r.db(y_meas))+10)/10)*10;
    end
    
    mag_axis.YLim       = [ymag_min ymag_max];
    mag_axis.YTick      = ymag_min:20:ymag_max;
    phase_axis.YLim     = [-95 95];
    phase_axis.YTick    = -90:30:90;
    
    %adjust grid
    mag_axis.XGrid      = 'on';
    mag_axis.YGrid      = 'on';
    phase_axis.XGrid    = 'on';
    phase_axis.YGrid    = 'on';
end
   
