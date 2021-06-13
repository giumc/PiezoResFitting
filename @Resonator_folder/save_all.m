
    %creates a folder (with tag specified in rf.tag)
    %with a csv and a .m with all resonator in folder
    % you can pass extra options to get more formatted data:
    % 'png' makes a folder BitmapImages with a .png of all resonators
    % 'vec' makes a folder VectorImages with a .eps .emf of all resonators
    % 'fig' makes a folder MatFigures with a .fig of all resonators
    % 'spice' to print a spice model of the resonator
    % 'data' makes a folder ResData with a .mat of all resonators
    % moreover, you can pass options to resonator.save as 
    % 'guioptions','opt1','opt2' to control extra figure options
    %
    % es: save all resonators png with minimal setup
    % r.save_all('png','guioptions','minimal','Visible','off');
    % ---- for list of options, help resonator.save ----
    
function flag=save_all(rf,varargin)

    flag=false;
    
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
    
    
    %write table and resonator folder data

    tab=rf.gen_table();

    
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
                    
                    if rf.makefolder(mainfolder,'BitmapImages')
                        
                        savefolder=strcat(mainfolder,...
                            'BitmapImages',filesep);
                        
                        lookallres(savefolder,...
                            'Saving PNG files',...
                            'png',guioptions{:});
                        
                        flag=true;
                        
                    end
                    
                case 'vec'
                    
                    if rf.makefolder(mainfolder,'VectorImages')
                        
                        savefolder=strcat(mainfolder,...
                            'VectorImages',filesep);
                        
                        lookallres(savefolder,...
                            'Saving V files',...
                            'vec',guioptions{:});
                        
                        flag=true;
                        
                    end
                    
                case 'fig'
                    
                    if rf.makefolder(mainfolder,'MatFigures')
                        
                        savefolder=strcat(mainfolder,...
                            'MatFIgures',filesep);
                        lookallres(savefolder,...
                            'Saving M figures',...
                            'fig',guioptions{:});
                        
                        flag=true;
                        
                    end
                case 'spice'
                    
                    if rf.makefolder(mainfolder,'SPICEfiles')
                        
                        savefolder=strcat(mainfolder,...
                            'SPICEfiles',filesep);
                        
                        lookallres(savefolder,...
                            'Saving SPIce files',...
                            'spice',guioptions{:});
                        
                        flag=true;
                        
                    end
                    
                case 'data'
                    
                    if rf.makefolder(mainfolder,'ResData')
                        
                        savefolder=strcat(mainfolder,...
                            'ResData',filesep);
                        
                        lookallres(savefolder,...
                            'Saving Resonator Data',...
                            'data',guioptions{:});
                        
                        flag=true;
                        
                    end
                    
            end
            
        end
        
    end
        
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
