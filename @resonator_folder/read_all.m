function outcome=read_all(rf)
    %clear folders with no sparam
    
    formats=rf.format_files;
    tbs=[];
    outcome=false;
    folderfiles=dir(rf.folder);
    for k=1:length(folderfiles)
        if contains(string(folderfiles(k).name),formats)
            tbs=[tbs,k];
        end
    end
    files=folderfiles(tbs);
   	rf.res_files=files;
    rf.progressbar('Initializing Resonators');
    if ~isempty(files)
        outcome=true;
        for k=1:length(files)
            fullpath=strcat(files(k).folder,filesep,files(k).name);
            rf.resonators(k)=resonator('file',fullpath);
            rf.resonators(k).tag=files(k).name;
            rf.resonators(k).max_modes=rf.max_modes;
            rf.progressbar(k/length(files));
        end
    end
    
end

