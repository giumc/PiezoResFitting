function prompt_folder(f)
    title='Select folder(s)';

    start_folder=fileparts(which('\@resonator_folder\resonator_folder.m'));

    outcome=uigetdir(start_folder,title);

    %add folders and subfolders
    
    if ~outcome
        return
    else
        f.folder=string(outcome);
    end       
    
end
