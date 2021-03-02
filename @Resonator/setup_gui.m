function figure=setup_gui(r,varargin)
    %you can pass options to figure
    %if you also pass 'minimal', only plots are created
    %if you don't pass anything, full gui will be created
    if isempty(r.y_meas)
        warndlg({'No measured data found\n',...
            'Assign measure with prompt_touchstone() method'})
    else
        if ~isempty(varargin)
            for i=1:length(varargin)
                if strcmp(varargin{i},'minimal')
                    varargin(i)=[];
                    r.setup_plot(varargin{:});
                    r.update_fig();
                    r.minimal_fig_setup();
                    figure=r.figure;
                    return
                end
            end
        end
        r.setup_plot(varargin{:});
        r.setup_bars();
        r.setup_boundaries_edit();
        r.setup_name_labels();
        r.setup_value_labels();
        r.setup_optim_checkbox();
        r.setup_headings();
        r.setup_buttons();
        r.update_fig();
    end
    
    figure=r.figure;
    
end
