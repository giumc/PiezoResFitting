function rejected_res=inspect(rf)
    % go through all the resonators, 
    % and select which ones to delete
    % the output is an array of the indexes of resonators to be deleted
    
    rejected_res=[];
    for i=1:length(rf.resonators)

        rf.resonators(i).setup_gui('minimal');
        selection=questdlg('Keep data?', ...
                    'Inspection', 'Yes');
        switch selection
            case 'Yes'
                rf.resonators(i).delete_gui;
            case 'No'
                rf.resonators(i).delete_gui;
                rejected_res=[rejected_res, i];
            case 'Cancel'
                rf.resonators(i).delete_gui;
                return
        end
    end
    
    if ~isempty(rejected_res)
        rejected_res=unique(rejected_res);
    end
    
end
