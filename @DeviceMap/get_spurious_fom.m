function x=get_spurious_fom(obj,table)
    
    namecells=table.Properties.VariableNames;
    
    fom=table.FoM_with_Rs;
    
    for i=1:length(namecells)
        
        if startsWith(namecells(i),'kt2')
            
            num_overtone=char(namecells(i));
            num_overtone=int(num_overtone(end));
            
            if ~(num_overtone)==1
                
                q=table.(sprintf("Q_%d",num_overtone))
                kt2=table.(sprintf("kt2_%d",num_overtone))
                fom=[fom,q*kt2];
            
            end
            
        end
            
    end
    
    fom=fom(1)/sum(fom);
    
end