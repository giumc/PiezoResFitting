function filepointer=gen_spicenetlist(r)

    folder=r.save_folder;
    
    filepointer=false;
    
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

    
    txt=strcat(txt,"C0 ","mp ", "2 ",num2str(r.c0.value)," \n");
    txt=strcat(txt,"R0 ","mp ","2 ",num2str(r.r0.value)," \n");
    txt=strcat(txt,"RS ","1 ", "mp ",num2str(r.rs.value)," \n");

    txt=strcat(sprintf("** Auto-generated SPICE model for resonator %s**\n ",r.tag),...
        "\n",".SUBCKT ",r.tag," "," 1 2 \n\n",txt,"\n.ENDS \n");
    
    filepointer=fopen(strcat(r.save_folder,filesep,r.tag,'.SPICE'),'w+');
    
    if ~filepointer
        
        error(sprintf("Could not write in \n \s",strcat(r.save_folder,filesep,r.tag,'.SPICE')));
        
    else
        
        
        fprintf(filepointer,sprintf(txt));
        
        filepointer=fclose(filepointer);
        
    end
       
    if ~filepointer
        
        flag=true;
        
    end
    
    function txt=gen_motional_branch_SPICE(L,C,R,n1,n2,i)
        
        txt=strcat("L",i," ",n1," ",n1,i,"a ",num2str(L)," \n");
        txt=strcat(txt,"C",i," ",n1,i,"a"," ",n1,i,"b ",num2str(C)," \n");
        txt=strcat(txt,"R",i," ",n1,i,"b"," ",n2," ",num2str(R)," \n");
        txt=sprintf(txt);
        
    end
    
end
