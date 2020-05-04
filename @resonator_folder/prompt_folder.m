function folder=prompt_folder(rf)
    title='Select folder(s)';

    start_folder=fileparts(which('\@resonator_folder\resonator_folder.m'));

    folder=uigetdir(start_folder,title);

    %add folders and subfolders to path
    
    if folder
        
        isonpath=which(folder);
        if ~isonpath
            addpath(genpath(folder));
            savepath;
        end
        rf.folder=folder;
        
    end       
    
end
