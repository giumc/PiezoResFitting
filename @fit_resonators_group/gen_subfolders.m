function folders=gen_subfolders(obj,name,folders)
        
    if ischar(folders)
        folders=string(folders);
    end
    
    if isfolder(name)
        if isempty(folders)
            folders=name;
        else
            folders=[folders;name];
        end
    end
    files=dir(name);
    files(...
        arrayfun(@(k)...
            any(strcmp(files(k).name,{'.','..','.git'})),1:length(files))...
        )=[];
    if isempty(files)
        return
    else
        for i=1:length(files)
            if files(i).isdir
                fullname=strcat(files(i).folder,...
                    filesep,...
                    files(i).name);
                folders=obj.gen_subfolders(fullname,folders);
            end
        end
    end
end
