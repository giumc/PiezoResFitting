function mot_branch=calculate_mot_branch(resonator,index)
    fres    =   mode(index).fres;
    q       =   mode(index).q;
    kt2     =   mode(index). kt2;
    c0      =   resonator.c0;
    
    mot_branch.Lm   =   pi^2 / 8  / (2*pi*fres)^2 / c0 / kt2 ;
    
    mot_branch.Cm   =   8 / pi^2 * c0 * kt2 ;
    
    mot_branch.Rm   =   pi^2 /8 / (2*pi*fres) / c0 / kt2 /q ;
end
