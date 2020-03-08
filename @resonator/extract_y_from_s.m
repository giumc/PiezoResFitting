function extract_y_from_s(resonator)
adm_meas =[];
    if isempty(resonator.sparam)|| ~isa(resonator.sparam,'sparameters')
        return ;
    else
        ypar = yparameters(resonator.sparam);
        if resonator.sparam.NumPorts==1
            adm_meas = rfparam(ypar, 1, 1);
        end
        if resonator.sparam.NumPorts==2
            adm_meas = - rfparam(ypar, 2, 1);
        end
    end

    if length(adm_meas)>resonator.max_samples
        adm_meas = downsample(adm_meas,ceil(length(adm_meas)/resonator.max_samples));
    end
    
    resonator.y_meas    =   adm_meas;

    smoothing_index     =   resonator.smoothing_data;
    
    resonator.y_smooth              =   resonator.y_meas;
        if (smoothing_index==0) || isempty (resonator.y_smooth )
            return ;
        else
            resonator.y_smooth    =   smooth(real(resonator.y_smooth ),...
                smoothing_index) + ...
                    1i* smooth(imag(resonator.y_smooth ),smoothing_index) ;
        end
end
