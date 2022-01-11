function s=get_MBVD_params(obj)
    
    s.C0=obj.c0.value;
    s.R0=obj.r0.value;
    s.Rs=obj.rs.value;
    mot=obj.calculate_mot_branch(1);
    s.Qm=obj.mode(1).q.value;
    s.kt2=obj.mode(1).kt2.value;
    s.Fres=obj.mode(1).fres.value;
    s.Lm=mot.Lm;
    s.Cm=mot.Cm;
    s.Rm=mot.Rm;
    s.Ql=obj.get_qloaded;
    
    
end