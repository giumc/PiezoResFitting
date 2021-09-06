function reject_folder=inspect(obj)
    % go through all the resonators, 
    % and select which ones to delete
    % rejected resonator data are stored in a subfolder 'Rejected'
    % return Resonator_folder of deleted items
    
    reject_foldername='_Rejected';
    
    rejected_res=[];
    
    reject_folder=Resonator_folder;
    
    reject_folder.folder=obj.folder;
    
    reject_folder.tag=reject_foldername;
    
    for i=1:length(obj.resonators)
    
        obj.resonators(i).setup_gui('minimal');
        
        selection=questdlg('Keep data?', ...
                    'Inspection', 'Yes');
        
        if strcmp(selection,'No')
            
            rejected_res=[rejected_res, i];
            
        end
                
        obj.resonators(i).delete_gui;
        
    end
    
    if ~isempty(rejected_res)
    
        reject_folder.res_files=obj.res_files(rejected_res);
        
        reject_folder.resonators=obj.resonators(rejected_res);
        
        reject_folder.save_all('data');
    
        delete(obj.resonators(rejected_res));
   
        obj.resonators(rejected_res)=[];
    
        obj.res_files(rejected_res)=[];
    
    end
        
end
