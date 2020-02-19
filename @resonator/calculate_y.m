function y=calculate_y(resonator)

    f   =   resonator.freq;
    c0  =   resonator.c0;
    r0  =   resonator.r0;
    rs  =   resonator.rs;
    
    y   =   2 * pi * f * c0 + 1 / r0 ;
    
    for j = 1 : length (resonator.mode)
        
       % y   =   y + 1 ./( 1i * 2 * pi * 
    end
end
