function t=gen_table(obj)
    
    t=gen_table@Resonator(obj);
    t=removevars(t,{'FoM','FoM_with_Rs','Rm','R0','Q_loaded'});
    
    fcap=obj.freq(ceil(end/2));
    t.Z0=1/2/pi/fcap/t.C0;
    t.Q=t.Z0/t.Rs;
    t=addvars(t,1/t.Q,'NewVariableNames',"TanD");
 
end