function tab=gen_table(obj)
    
    obj.progressbar('Getting Summary Table');
    
    tab=[];
    
    for i=1:length(obj.resonators)
        
        t=obj.resonators(i).gen_table;
        
        tab=[tab; t];
         
        obj.progressbar(i/length(obj.res_files));
        
    end
        
end