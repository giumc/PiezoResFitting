function folder_set_callback(~,~,obj)
    %clear folders with no sparam

    formats=obj.format_files;
    tbs=[];

    folderfiles=dir(obj.folder);
    for k=1:length(folderfiles)
        if contains(string(folderfiles(k).name),formats)
            tbs=[tbs,k];
        end
    end
    files=folderfiles(tbs);
   	obj.res_files=files;
    obj.progressbar('Initializing Resonators');
    for k=1:length(files)
        fullpath=strcat(files(k).folder,filesep,files(k).name);
        obj.resonators(k)=resonator('file',fullpath);
        obj.resonators(k).tag=files(k).name;
        obj.resonators(k).max_modes=obj.max_modes;
        obj.progressbar(k/length(files));
    end
    
    obj.fit_all;
    obj.save_results('printfig','minimal','Visible','off');
    
end

