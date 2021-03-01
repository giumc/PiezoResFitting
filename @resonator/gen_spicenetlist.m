function filepointer=gen_spicenetlist(obj)

    folder=obj.save_folder;
    
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
    
    for i=1:length(obj.mode)
    
        LCR=obj.calculate_mot_branch(i);
        L=LCR.Lm;
        C=LCR.Cm;
        R=LCR.Rm;
        
        txt=strcat(txt,gen_motional_branch_SPICE(L,C,R,"mp","2",num2str(i)));
        
    end

    
    txt=strcat(txt,"C0 ","mp ", "2 ",num2str(obj.c0.value)," \n");
    txt=strcat(txt,"R0 ","mp ","2 ",num2str(obj.r0.value)," \n");
    txt=strcat(txt,"RS ","1 ", "mp ",num2str(obj.rs.value)," \n");

    txt=strcat(sprintf("** Auto-generated SPICE model for resonator %s**\n ",obj.tag),...
        "\n",".SUBCKT ",obj.tag," "," 1 2 \n\n",txt,"\n.ENDS \n");
    
    filepointer=fopen(strcat(obj.save_folder,filesep,obj.tag,'.SPICE'),'w+');
    
    if ~filepointer
        
        error(sprintf("Could not write in %s \n",strcat(obj.save_folder,filesep,obj.tag,'.SPICE')));
        
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
