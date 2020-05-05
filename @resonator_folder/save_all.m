function outcome=save_all(rf,varargin)
    %creates a folder (with tag specified in rf.tag)
    %which contains a subfolder for each format
    % ---- for list of possible formats, see resonator.save ----
    %by defaults, it generates a csv and a .m with resoantor folder data
    outcome=false;
    if isempty(rf.resonators)
        return
    end
    [folderpath,foldername]=fileparts(rf.folder);
    foldername=strcat(foldername,rf.tag);
    if ~rf.makefolder(folderpath,foldername)
        return
    end
    mainfolder=strcat(folderpath,filesep,foldername,filesep);
    % save results and get summary from resonators
    tab=[];
    
    %write table and resonator folder data
    rf.progressbar('Saving Summary Table');
    for i=1:length(rf.resonators)
        
        tab=[tab; rf.resonators(i).data_table];
        rf.progressbar(i/length(rf.res_files));
    end
    rf.data_table=tab;
    tablename=strcat(mainfolder,'Summary.csv');
    writetable(rf.data_table,tablename,'WriteRowNames',true);
    
    resfold=rf;  
    save(strcat(mainfolder,'folderdata.mat'),'resfold');
    
    %look for save options and pass to resonator.save
   
    guioptions={};
    if ~isempty(varargin)
        
        %look first for guioptions
        for i=1:length(varargin)
            if strcmp(varargin{i},'guioptions')
                if ~isempty(varargin{i+1})
                    guioptions={varargin{i:end}};
                end
            end
        end
        % then look for options and create subfolders accordingly
        for i=1:length(varargin)
            switch varargin{i}
                case 'png'
                    flag=rf.makefolder(mainfolder,'BitmapImages');
                    if flag
                        savefolder=strcat(mainfolder,...
                            'BitmapImages',filesep);
                        lookallres(savefolder,...
                            'Saving PNG files',...
                            'png',guioptions{:});
                    end
                case 'fig'
                    flag=rf.makefolder(mainfolder,'VectorImages');
                    if flag
                        savefolder=strcat(mainfolder,...
                            'VectorImages',filesep);
                        lookallres(savefolder,...
                            'Saving V files',...
                            'fig',guioptions{:});
                    end

                case 'data'
                    
                    flag= rf.makefolder(mainfolder,'ResData');
                    if flag
                        savefolder=strcat(mainfolder,...
                            'ResData',filesep);
                        lookallres(savefolder,...
                            'Saving Resonator Data',...
                            'data',guioptions{:});
                    end
            end
        end
    end
    outcome=true;    
    % aux function to lookup and parse right save command
    function lookallres(folder,msg,varargin)
        
        rf.progressbar(msg);
        
        for k=1:length(rf.resonators)
            %flush resonators to same number of modes
            rf.resonators(k).save_folder=folder;
            rf.resonators(k).save(varargin{:});
            rf.progressbar(k/length(rf.res_files));
        end
        
    end
%     
end
