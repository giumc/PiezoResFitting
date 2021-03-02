function set_freq(r)

    if isempty(r.touchstone_file)
        r.freq   =  ( 0.9 : 0.001 : 1.1 ) * 1e9 ;%default
    else
        r.freq   =   r.sparam.Frequencies;
        if length(r.freq)>r.max_samples
            r.freq   =   downsample(r.freq,...
                ceil(length(r.freq)/r.max_samples));
        end
    end
    
    if r.interp_points>0
        r.freq_smooth = interp1(...
            r.freq,1:1/r.interp_points:length(r.freq));
    else
        r.freq_smooth = r.freq;
    end
    
end
