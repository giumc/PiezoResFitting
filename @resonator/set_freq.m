function set_freq(resonator)
    if isempty(resonator.touchstone_file)
        resonator.freq   =  ( 0.9 : 0.001 : 1.1 ) * 1e9 ;%default
    else
        resonator.freq   =   resonator.sparam.Frequencies;
        if length(resonator.freq)>resonator.max_samples
            resonator.freq   =   downsample(resonator.freq,...
                ceil(length(resonator.freq)/resonator.max_samples));
        end
    end
end
