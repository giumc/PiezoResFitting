function save_results(rf,varargin)

    if isempty(rf.resonators)
        return
    end

    savefolder=strcat(rf.folder,filesep,rf.result_tag);
    filelist=dir(rf.folder);
    token=0;
    
    %make folder if there isn't one already
    for i=1:length(filelist)
        
        if filelist(i).isdir==true && strcmp({filelist(i).name},rf.result_tag)
        
            token=1;
            break
            
        end
        
    end
    if token==0
        
        mkdir(savefolder);
    
    end  
    
    % save results and get summary from resonators
    tab=[];
    for i=1:length(rf.res_files)
        
        tab=[tab; rf.resonators(i).data_table];
        rf.resonators(i).save_folder=savefolder;
        rf.resonators(i).save_results(varargin{:});
        
    end
    
    rf.data_table=tab;
    tablename=strcat(savefolder,filesep,'Summary.csv');
    writetable(rf.data_table,tablename,'WriteRowNames',true);

    
end