function set_sparam(resonator)
    if isempty(resonator.touchstone_file)
        resonator.sparam      =    [];
    else
        resonator.sparam  =   sparameters(resonator.touchstone_file);
    end
end
