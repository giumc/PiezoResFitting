function outcome=save(obj,varargin)
   %by default, it saves png and .m file
   %in the same folder as the s2p file
   %
   %pass as many options as you need:
   %'png' to print png
   %'vec' to print eps and emf file
   %'fig' to print fig file
   %'tab' to print table
   %'spice' to print a spice model of the resonator
   %'full' to print png,eps,fig,csv and mat file with res data
   %'data' to save only .m data file
   % OSS:
   % pass extra arguments to setup_gui() as follows:
   % 'guioptions','opt1','opt2',... as last arguments
   
   outcome=false;
    if isempty(obj.data_table)
        obj.data_table=gen_table(obj);
    end
    
    if ~isempty(obj.save_folder)
        if isfolder(obj.save_folder)
            savepathfile=obj.save_folder;        
        else
            addpath(obj.save_folder)
            if isfolder(obj.save_folder)
                savepathfile=obj.save_folder;        
            else
                error("Cannot get to %s \n,abort",obj.save_folder);
                
            end
        end
    else
        folder_tag=strcat(obj.tag," ",'Fit Result');
        if obj.makefolder(obj.touchstone_folder,folder_tag)
            obj.save_folder=strcat(obj.touchstone_folder,filesep,folder_tag,filesep);
            savepathfile=obj.save_folder;
        else
            error("No save folder for %s, abort\n",obj.tag);
            
        end
    end
         
    filename=regexprep(obj.tag,'.[sS][12][pP]','');
    
    filepath=strcat(savepathfile,filename);
    
    tablename=strcat(filepath,'.csv');
    
    resobj=obj;
    
    printflag=fprintf("Saving %s resonator data",filename);
    guioptions={};
    %look for guioptions first
    if ~isempty(varargin)
        for i=1:length(varargin)
            if strcmp(varargin{i},'guioptions')
                if ~isempty(varargin{i+1})
                    guioptions={varargin{i+1:end}};
                    break
                end
            end
        end
    end
        
    if ~isempty(varargin)
        
        for i=1:length(varargin)
            
            switch varargin{i}
                
                case 'png'
                    
                    obj.setup_gui(guioptions{:});
                    print(obj.figure,filepath,'-dpng','-r100');
                    obj.delete_gui;
                    outcome=true;
                    
                case 'vec'
                    
                    obj.setup_gui(guioptions{:});
                    print(obj.figure,filepath,'-depsc','-r0','-painters');
                    print(obj.figure,filepath,'-dmeta','-r0','-painters');
                    obj.delete_gui;
                    outcome=true;
                    
                case 'fig'
                    
                    obj.setup_gui(guioptions{:});
                    savefig(obj.figure,filepath);
                    obj.delete_gui;
                    outcome=true;
                    
                case 'data'
                    save(strcat(filepath,'.mat'),'resobj');
                    outcome=true;
                case 'spice'
                    
                    obj.gen_spicenetlist;
                    outcome=true;
                         
                case 'tab'
                    
                    writetable(obj.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
                    outcome=true;
                    
                case 'full'
                    obj.setup_gui(guioptions{:});
                    savefig(obj.figure,filepath);
                    obj.gen_spicenetlist;
                    print(obj.figure,filepath,'-depsc','-r0','-painters');
                    obj.delete_gui;
                    writetable(obj.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
                    save(strcat(filepath,'.mat'),'resobj');
                    outcome=true;
                    
                    break
                    
            end
            
        end
        
    else
        
        obj.setup_gui('minimal','Visible','off');
        print(obj.figure,filepath,'-dpng','-r100');
        obj.delete_gui;
        writetable(obj.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
        save(strcat(filepath,'.mat'),'resobj');
        outcome=true;
        
    end

    fprintf(repmat('\b',1,printflag))
    
end
