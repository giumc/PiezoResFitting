function token=makefolder(folderpath,name)
    
    pathcell = regexp(path, pathsep, 'split');
    if ispc  % Windows is not case-sensitive
      onpath = any(strcmpi(folderpath, pathcell));
    else
      onpath = any(strcmp(folderpath, pathcell));
    end
    
    if ~onpath
        addpath(genpath(folderpath));
        savepath;
    end
    
    filelist=dir(folderpath);
    token=0;

    fullname=strcat(folderpath,filesep,name);
    %make folder if there isn't one already
    %if there is one, empty it
    for i=1:length(filelist)

        if filelist(i).isdir==true && ....
                strcmp({filelist(i).name},name)

            token=1;
                toberem=dir(strcat(filelist(i).folder,...
                    filesep,...
                    filelist(i).name));
                for k=1:length(toberem)
                    fullname=strcat(toberem(k).folder,...
                            filesep,...
                            toberem(k).name);
                    if toberem(k).isdir
                        if ~any(strcmp(toberem(k).name,{'.','..'}))
                            rmdir(fullname,'s');
                        end
                    else
                        delete(fullname);
                    end
                end
            break
        end
    end
    
    if token==0

        token=mkdir(fullname);
        
        if token==0
            fprintf('Could not create folder %s in %s,abort\n',...
                folderpath,name);
        end
        
    end  
end



