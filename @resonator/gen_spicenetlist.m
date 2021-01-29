function flag=gen_spicenetlist(r)

    folder=r.save_folder;
    
    flag=false;
    
    txt="";
    
    if isempty(folder)
        
        error("Error while writing SPICE netlist: Folder Not Set!\n")
        
    else
        
        if ~isfolder(folder)
            
            addpath(folder);
            savepath;
            
            if ~isfolder(folder)
                
                error("Error while writing SPICE netlist: Folder Not Valid!\n")
                
            end
            
        end
        
    end
    
    for i=1:length(r.mode)
    
        LCR=r.calculate_mot_branch(i);
        L=LCR.Lm;
        C=LCR.Cm;
        R=LCR.Rm;
        
        txt=strcat(txt,gen_motional_branch_SPICE(L,C,R,"mp","2",num2str(i)));
        
    end
%     keyboard
    txt=strcat(txt,"C ",num2str(r.c0.value),"mp ", "2 \n");
    txt=strcat(txt,"R ",num2str(r.r0.value),"mp ", "2 \n");
    txt=strcat(txt,"R ",num2str(r.rs.value),"1 ", "2 \n");
    
    fprintf(txt);
    
    function txt=gen_motional_branch_SPICE(L,C,R,n1,n2,i)
        
        txt=strcat("L ",num2str(L)," ",n1," ",n1,i,"a"," \n");
        txt=strcat(txt,"C ",num2str(C)," ",n1,i,"a"," ",n1,i,"b"," \n");
        txt=strcat(txt,"R ",num2str(R)," ",n1,i,"b"," ",n2," \n");
        txt=sprintf(txt);
        
    end
    
end
