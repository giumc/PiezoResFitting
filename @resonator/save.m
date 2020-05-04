function outcome=save(r,varargin)
   
   %pass as many options as you need:
   %'png' to print png
   %'fig' to print eps and fig file
   %'tab' to print table
   %'full' to print png,eps,fig,csv and mat file with res data
   %'data' to save only .m data file
   % OSS:
   % pass extra arguments to setup_gui() as follows:
   % 'guioptions','opt1','opt2',... as last arguments
   
   outcome=false;
    if isempty(r.data_table)
        r.data_table=gen_table(r);
    end
    
    if ~isempty(r.save_folder)
        if isfolder(r.save_folder)
            savepathfile=r.save_folder;        
        else
            fprintf("No save folder for %s, abort\n",r.tag);
            return
        end
    end
    
    filename=regexprep(r.tag,'.[sS][12][pP]','');
    
    filepath=strcat(savepathfile,filename);
    
    tablename=strcat(filepath,'.csv');
    
    resobj=r;
    
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
                    r.setup_gui(guioptions{:});
                    print(r.figure,filepath,'-dpng','-r100');
                    r.delete_gui;
                case 'fig'
                    r.setup_gui(guioptions{:});
                    savefig(r.figure,filepath);
                    print(r.figure,filepath,'-depsc','-r0','-painters');
                    r.delete_gui;
                case 'data'
                    save(strcat(filepath,'.mat'),'resobj');
                case 'full'
                    r.setup_gui(guioptions{:});
                    savefig(r.figure,filepath);
                    print(r.figure,filepath,'-depsc','-r0','-painters');
                    r.delete_gui;
                    writetable(r.data_table,tablename,'WriteRowNames',true);%,'FileType','.csv');
                    save(strcat(filepath,'.mat'),'resobj');
                    break
            end
        end
    end
    
    
    fprintf(repmat('\b',1,printflag))
    
end
