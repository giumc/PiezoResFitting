function prompt_folder(f)
    title='Select folder(s)';

    start_folder=fileparts(which('fit_resonators_group.m'));
    start_folder=strrep(start_folder,'\@fit_resonators_group','');


    outcome=uigetdir(start_folder,title);

    %add folders and subfolders
    if ~outcome
        return
    else
        f.folder=string(outcome);
    end       
    
end
