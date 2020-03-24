function y= calculate_y(resonator)
    f   =   resonator.freq_smooth;
    c0  =   resonator.c0.value;
    r0  =   resonator.r0.value;
    rs  =   resonator.rs.value;
    
    y   =   1i * 2 * pi * f * c0 + 1 / r0 ;
    
    for j = 1 : length (resonator.mode)
        
        mot_branch = calculate_mot_branch(resonator,j);
        
        Lm      =   mot_branch.Lm ;
        Cm      =   mot_branch.Cm ;
        Rm      =   mot_branch.Rm ;
        
        z_mot   =   ( 1i * 2 * pi * f * Lm ) + 1 ./ ( 1i * 2 * pi * f * Cm ) + Rm ;
        
        y       =   y + 1./z_mot ;
        
    end
    
    z_b =  1./y ;
    z_t =  z_b + rs ;
    y   =  1./z_t;
    
end
