function y= get_y(obj)

    f   =   obj.freq_smooth;

    c0  =   obj.c0.value;
    r0  =   obj.r0.value;
    rs  =   obj.rs.value;
    
    y   =   1i * 2 * pi * f * c0 ;
    
    for j = 1 : length (obj.mode)
        
        mot_branch = calculate_mot_branch(obj,j);
        
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
