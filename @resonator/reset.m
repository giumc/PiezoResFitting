function reset(r)
            
            while length(r.mode)>1
                r.remove_mode;
            end
            
            delete(r.mag_axis)
            r.mag_axis=[];
            delete(r.phase_axis)
            r.phase_axis=[];
            delete([r.boundaries_edit{:}])
            r.boundaries_edit(:)=[];
            delete(r.boundaries_bars);
            r.boundaries_bars=[];
            delete(r.param_value_labels);
            r.param_value_labels=[];
            delete(r.param_name_labels);
            r.param_name_labels=[];
            delete(r.param_value_labels);
            r.param_value_labels=[];
            delete(r.action_buttons);
            r.action_buttons=[];

            r.set_default_param;
            r.guess_coarse;
            r.setup_plot;
            r.setup_buttons;
            r.setup_bars;
            r.update_fig;
        end
