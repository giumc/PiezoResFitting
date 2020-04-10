function files=find_files(f,folder)
    formats=f.format_files;
    files=dir(folder);
    tbs=[];
    for i=1:length(files)
        if contains(files(i).name,formats)
            tbs=[tbs i];
        end
    end
    files=files(tbs);
    return 
            
