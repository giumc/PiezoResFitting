function inspect(rf)
    % go through all the resonators, 
    % and select which ones to delete
    % rejected resonator data are stored in a subfolder 'Rejected'
    % for further analysis
    
    reject_foldername='_Rejected';
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
        
%         if rf.makefolder(rf.folder,reject_foldername)
%             savefolder=strcat(rf.folder,filesep,reject_foldername);
%             for i=1:length(rejected_res)
%                 oldloc=strcat(rf.res_files(rejected_res(i)).folder,...
%                     filesep,...
%                     rf.res_files(rejected_res(i)).name);
%                 newloc=strcat(savefolder,...
%                     filesep,...
%                     rf.res_files(rejected_res(i)).name);
%                 copyfile(oldloc,newloc);
%             end
%         else
%             return
%         end
        reject_folder=Resonator_folder;
        reject_folder.folder=rf.folder;
        reject_folder.tag=reject_foldername;
        reject_folder.res_files=rf.res_files(rejected_res);
        reject_folder.resonators=rf.resonators(rejected_res);
        reject_folder.save_all('data');
    end
        
    delete(rf.resonators(rejected_res));
    rf.resonators(rejected_res)=[];
    rf.res_files(rejected_res)=[];
    
end
