function delete_gui(r)
if isempty(r.figure)
    return
end

    mydelete(r.mag_axis);
    r.mag_axis=[];
    mydelete(r.phase_axis);
    r.phase_axis=[];
    mydelete(r.boundaries_bars);
    r.boundaries_bars=[];
    mydelete([r.boundaries_edit{:}]);
    r.boundaries_edit=[];
    mydelete(r.param_value_labels);
    r.param_value_labels=[];
    mydelete(r.param_name_labels);
    r.param_name_labels=[];
    mydelete(r.optim_checkbox);
    r.optim_checkbox=[];
    mydelete(r.action_buttons);
    r.action_buttons=[];
    mydelete(r.figure);
    r.figure=[];

    function mydelete(obj)
        if ~isempty(obj)
            if isvalid(obj)
                delete(obj)
            end
        end
    end  

end
