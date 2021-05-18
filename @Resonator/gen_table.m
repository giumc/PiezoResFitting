function tab=gen_table(r)
    
    tot_param=3*r.max_modes+3;
    vars=zeros(1,length(tot_param));
    names=repmat("",1,length(tot_param));
    
    for i=1:tot_param
        
        if i<=r.n_param
            
            vars(i)=r.get_param(i).value;
            names(i)=r.get_param(i).label;

        else
            
            vars(i)=NaN;
            names(i)=r.param_name(i);
            
        end
    end
    
    rs=r.rs.value;
    
    if length(r.mode)>=1
        
        q1=r.mode(1).q.value;
        
        kt1=r.mode(1).kt2.value;

        rm1=r.calculate_mot_branch(1).Rm;

        fcenter=r.mode(1).fres.value;

        if any(isnan([kt1,q1,rm1,rs]))

            FOM=NaN;
            FOM_w_Rs=NaN;
            Q_loaded=NaN;
            
        else

            FOM=kt1*q1;
            FOM_w_Rs=FOM*rm1/(rm1+rs);
            Q_loaded=q1*rm1/(rm1+rs);

        end

       
    else

    FOM=NaN;
    FOM_w_Rs=NaN;
    Q_loaded=NaN;
    
    fcenter=r.freq(ceil(end/2));
    q1=NaN;
    kt1=NaN;
    rm1=NaN;
    
    end
    
    Z0=1/2/pi/fcenter/r.c0.value;
    
    vars=[Z0,FOM, FOM_w_Rs,Q_loaded,rm1,vars];
    names=["Z0","FoM","FoM_with_Rs","Q_loaded","Rm",names];

    tab=array2table(vars);
    
    tab.Properties.VariableNames=names;
    tab.Properties.RowNames=string(r.tag);
    tab.Properties.DimensionNames={'Resonator','Parameters'};
    
    r.data_table=tab;
    
end
