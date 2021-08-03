function fom=get_fom_with_rs(obj)
    
    fom=NaN;
    
    if length(obj.mode)>=1

        q1=obj.mode(1).q.value;

        kt1=obj.mode(1).kt2.value;

        rm1=obj.calculate_mot_branch(1).Rm;

        rs=obj.rs.value;

        if ~any(isnan([kt1,q1,rm1,rs]))

            fom=kt1*q1*rm1/(rm1+rs);

        end
            
    end
    
end