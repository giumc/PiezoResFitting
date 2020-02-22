function adm_meas = extract_y_from_s(resonator)
adm_meas =[];
    if isempty(resonator.sparam)|| ~isa(resonator.sparam,'sparameters')
        return ;
    else
        ypar = yparameters(resonator.sparam);
        if resonator.sparam.NumPorts==1
            adm_meas = rfparam(ypar, 1, 1);
        end
        if resonator.sparam.NumPorts==2
            adm_meas = rfparam(ypar, 2, 1);
        end
    end
end
