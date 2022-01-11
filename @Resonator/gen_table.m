function tab=gen_table(obj)
    
    tot_param=3*obj.max_modes+3;
    vars=zeros(1,length(tot_param));
    names=repmat("",1,length(tot_param));
    
    for i=1:tot_param
        
        if i<=obj.n_param
            
            vars(i)=obj.get_param(i).value;
            names(i)=obj.get_param(i).label;

        else
            
            vars(i)=NaN;
            names(i)=obj.param_name(i);
            
        end
        
    end

    if length(obj.mode)>=1

        names_aux=["Z0","TanD","FoM","FoM_with_Rs","Q_loaded","Rm"];
        
        vars_aux=[obj.get_Z0,...
            obj.get_tand,...
            obj.get_fom,...
            obj.get_fom_with_rs,...
            obj.get_qloaded,...
            obj.calculate_mot_branch(1).Rm];
            
            if length(obj.mode)>1
                
                vars_aux=[vars_aux,...
                    obj.get_spurious_fom];
                names_aux=[names_aux,"Spurious[%]"];
                   
            end
           
            vars=[vars_aux,vars];
            names=[names_aux,names];

    end
    
    tab=array2table(vars);
    
    tab.Properties.VariableNames=names;
    tab.Properties.RowNames=string(obj.tag);
    tab.Properties.DimensionNames={'Resonator','Parameters'};
    
    obj.data_table=tab;
    
end
