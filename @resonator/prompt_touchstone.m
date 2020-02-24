function prompt_touchstone(resonator)

choice=uigetfile('*.*','Select Sparameter file');
if choice==0
    return;
end
if contains(choice,'.s1p')||contains(choice,'.s2p')
    resonator.touchstone_file   =   choice;
    y_meas                      =   resonator.y_meas;
    freq                        =   resonator.freq;
    
end

end
