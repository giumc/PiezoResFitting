function set_sparam(r)
    if isempty(r.touchstone_file)
        r.sparam    =   [];
        r.y_meas    =   [];
        r.y_smooth  =   [];
    else
        if ~exist(r.touchstone_file,'file')
            addpath(genpath(r.touchstone_file));
            savepath;
            rehash;
        end
        r.sparam  =   sparameters(r.touchstone_file);
    end
end
