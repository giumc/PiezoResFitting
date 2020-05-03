function save_results(rf,varargin)
    %pass option 'printfig' to print figure
    %pass option 'minimal' to include only sparam in figure
    %pass extra options to figure(varargin)
    if isempty(rf.resonators)
        return
    end

    savefolder=strcat(rf.folder,filesep,rf.result_tag);
    filelist=dir(rf.folder);
    token=0;
    
    %make folder if there isn't one already
    %if there is one, empty it
    for i=1:length(filelist)
        
        if filelist(i).isdir==true && strcmp({filelist(i).name},rf.result_tag)
        
            token=1;
%             delete(strcat(filelist(i).folder),filesep,filelist(i).name,filesep,'*');
            break
            
        end
        
    end
    if token==0
        
        mkdir(savefolder);
    
    end  
    
    % save results and get summary from resonators
    tab=[];
    rf.progressbar('Saving Resonators')
    for i=1:length(rf.resonators)
        %flush resonators to same number of modes
        
        tab=[tab; rf.resonators(i).data_table];
        rf.resonators(i).save_folder=savefolder;
        rf.resonators(i).save_results(varargin{:});
        rf.progressbar(i/length(rf.res_files));
    end
    
    %write table and resonator folder data
    rf.data_table=tab;
    tablename=strcat(savefolder,filesep,'Summary.csv');
    writetable(rf.data_table,tablename,'WriteRowNames',true);
    resfold=rf;  
    save(strcat(savefolder,filesep,'folderdata.mat'),'resfold');
    
end
