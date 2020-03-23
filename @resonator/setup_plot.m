function setup_plot(res)

dxfig= res.dxfig;
dyfig= res.dyfig;
x0fig= res.x0fig;
y0fig= res.y0fig;
spacing=res.button_spacing;
%% Figure

if ~isempty(res.figure)
    if isobject(res.figure) 
        if isvalid(res.figure)
            delete(res.figure.Children);
        else
            res.figure=figure;
        end
    else
        res.figure=figure;
    end
else
    res.figure=figure;
end

    res.figure.Name='Resonator Optimizer';
    res.figure.Units='normalized';
    res.figure.OuterPosition=[0 0 1 1];
    res.figure.WindowState='maximized';
    
%% Axes

mag_axis_name   = 'Y Magnitude';
phase_axis_name = 'Y Phase';

mag_axis                =   axes(res.figure);
mag_axis.Title.String   =   mag_axis_name;
mag_axis.OuterPosition       =   [x0fig y0fig+dyfig+spacing dxfig dyfig];
mag_axis.YLabel.String  =   '[dB]';
mag_axis.NextPlot       =   'replace';
mag_axis.Color          =   rgb('white');
mag_axis.GridLineStyle  =   '-.';

mag_legend              =   legend(mag_axis);
mag_legend.Visible      =   'on';
mag_legend.Color        =   'none';
mag_legend.Box          =   'off';
mag_legend.Location     =   'southeast';

figure(res.figure);
phase_axis              =   axes(res.figure);
phase_axis.Title.String =   phase_axis_name;
phase_axis.OuterPosition     =   [x0fig y0fig dxfig dyfig];
phase_axis.YLabel.String=   '[\circ]';
phase_axis.NextPlot     =   'replace';
phase_axis.Color        =   rgb('white');
phase_axis.GridLineStyle  =   '-.';

phase_legend            =   legend(phase_axis);
phase_legend.Visible    =   'on';
phase_legend.Color      =   'none';
phase_legend.Box        =   'off';
phase_legend.Location   =   'southeast';

res.mag_axis            =   mag_axis;
res.phase_axis          =   phase_axis;
res.mag_legend          =   mag_legend;
res.phase_legend        =   phase_legend;

end


