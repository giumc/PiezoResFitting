function save_results (r,varargin)
    %pass option 'printfig' to print figure
    %pass option 'minimal' to include only sparam in figure
    %pass extra options to figure(varargin)
    if isempty(r.data_table)
        r.data_table=gen_table(r);
    end
    
    if ~isempty(r.save_folder)
        if isfolder(r.save_folder)
            savepathfile=r.save_folder;
        else
            fprintf("Invalid save folder, setting to default...\n\n");
        end
    else
        if ~isempty(r.touchstone_file)|| isempty(r.save_folder)
        savepathfile=fileparts(which(r.touchstone_file));
        else
            savepathfile=fileparts(which('resonator.m'));
        end
    end
    
    r.save_folder=savepathfile;
    [~,filename]=fileparts(which(r.touchstone_file));
    if isempty(filename)
        addpath(genpath(fileparts(r.touchstone_file)));
        savepath;
        rehash;
        [~,filename]=fileparts(which(r.touchstone_file));
    end
    filename=regexprep(filename,'.[sS][12][pP]','');
    folder_tag=strcat(filename,'_Fit_Data');
    
    filelist=dir(savepathfile);
    token=0;
    
    for i=1:length(filelist)
        
        if filelist(i).isdir==true && strcmp({filelist(i).name},folder_tag)
            token=1;
            break
        end
    end
    
    savepathfile=strcat(savepathfile,filesep,folder_tag);
    
    if token==0
        
        mkdir(savepathfile);
    
    else
        
        delete(strcat(savepathfile,'\*'))
        
    end
    
    filepath=strcat(savepathfile,filesep,filename);
    printflag=fprintf("Saving %s resonator data",filename);
    
    printfig=false;
    if ~isempty(varargin)
        for i=1:length(varargin)
            if strcmp(varargin{i},'printfig')
                printfig=true;
                varargin(i)=[];
                break
            end
        end
    end
     
    if printfig
        r.setup_gui(varargin{:});
        savefig(r.figure,filepath);
        print(r.figure,filepath,'-dpng','-r150');
        print(r.figure,filepath,'-depsc','-r0','-painters');
        r.delete_gui;
    end    
    
    resobj=r;
    
    save(strcat(filepath,'.mat'),'resobj');
    tablename=strcat(filepath,'.csv');
    writetable(r.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
    % assign files to outputfiles
    
%     files=dir(
    
    fprintf(repmat('\b',1,printflag))
    
end
