function set_sparam(r)
    if isempty(r.touchstone_file)
        r.sparam    =   [];
        r.y_meas    =   [];
        r.y_smooth  =   [];
    else
        r.sparam  =   sparameters(r.touchstone_file);
    end
end
