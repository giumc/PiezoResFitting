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
    
    for k=1:length(files)
        fullpath=strcat(files(k).folder,filesep,files(k).name);
        obj.resonators(k)=resonator('file',fullpath);
        obj.resonators(k).tag=files(k).name;
    end
end

