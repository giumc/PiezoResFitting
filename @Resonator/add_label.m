function add_label(obj)
   
    if isempty(obj.figure)
        
        return
    
    end
    
    f=obj.figure;
    
    a=obj.mag_axis;
    
    rm= obj.calculate_mot_branch(1).Rm;
    
    rs= obj.rs.value;
    
    c0= obj.c0.value;
    
    kt2=obj.mode(1).kt2.value;
    
    qm=obj.mode(1).q.value;
    
    fres=obj.mode(1).fres.value;
    
    qloaded=obj.get_qloaded;
    
    s1=[...    
        sprintf('R_s = %.2f ',rs),'\Omega',newline,...
        sprintf('R_m = %.2f ',rm),'\Omega',newline,...
        sprintf('C_0 = %.2f pF ',c0/1e-12)];
        
    s2=[...
        sprintf('Q_m = %.0f ',qm),newline,...
        sprintf('Q_{loaded} = %.0f',qloaded)];
    
    s3=[...
        sprintf('k_t^2 = %.2f %%',kt2*1e2),newline,...
        sprintf('F_{res} = %.2f MHz',fres/1e6)];
    
    t1=annotation(f,'textbox');
    t1.String=s1;
    t1.LineStyle='none';
    t1.Position([1,2])=[0.1582    0.8050 ];
    t1.FontSize=20;
    t1.FontWeight='normal';
    
    t2=annotation(f,'textbox');
    t2.String=s2;
    t2.LineStyle='none';
    t2.Position([1,2])=[0.1572    0.5736];
    t2.FontSize=20;
    t2.FontWeight='normal';
    
    t3=annotation(f,'textbox');
    t3.String=s3;
    t3.LineStyle='none';
    t3.Position([1,2])=[0.6586    0.8433];
    t3.FontSize=20;
    t3.FontWeight='normal';
    
end