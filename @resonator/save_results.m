function save_results (r)

    if isempty(r.data_table)
        r.data_table=gen_table(r);
    end
    
    if ~isempty(r.save_folder)
        if isfolder(r.save_folder)
            savepath=r.save_folder;
        else
            fprintf("Invalid save folder, setting to default...\n\n");
        end
    else
        if ~isempty(r.touchstone_file)|| isempty(r.save_folder)
        savepath=fileparts(which(r.touchstone_file));
        else
            savepath=fileparts(which('resonator.m'));
        end
    end
    
    r.save_folder=savepath;
    filename=regexprep(r.touchstone_file,'.s[12]p','');
    folder_tag=strcat(filename,'_Fit_Data');
    
    filelist=dir(savepath);
    token=0;
    
    for i=1:length(filelist)
        
        if filelist(i).isdir==true && strcmp({filelist(i).name},folder_tag)
            token=1;
        end
    end
    
    savepath=strcat(savepath,filesep,folder_tag);
    
    if token==0
        
        mkdir(savepath);
    
    end
    
    filepath=strcat(savepath,filesep,filename);
    
    r.setup_gui('Visible','off');
    savefig(r.figure,filepath);
    resobj=r;
    
    print(r.figure,filepath,'-dpng','-r150');
    print(r.figure,filepath,'-depsc','-r0','-painters');
    r.delete_gui;
    save(strcat(filepath,'.mat'),'resobj');
    tablename=strcat(filepath,'.csv');
    writetable(r.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
end
