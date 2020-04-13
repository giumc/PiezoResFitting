function setup_gui(r,varargin)
    
    if isempty(r.y_meas)
        warndlg({'No measured data found\n',...
            'Assign measure with prompt_touchstone() method'})
    else
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
    
end
