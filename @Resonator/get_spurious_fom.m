function val=get_spurious_fom(obj)

        fom=obj.get_fom_with_rs;
        
        for i=1:length(obj.mode)
            
            fom_aux(i)=obj.get_fom(i);
            
        end
        
        val=sum(fom_aux)/fom;
        
end