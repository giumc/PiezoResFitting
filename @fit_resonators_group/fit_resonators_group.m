classdef fit_resonators_group <handle
    
    properties (Constant)
        format_files=[".s1p";".s2p";".S1P";".S2P"];
    end
    
    properties(SetObservable,AbortSet)
        folder='';       
    end
    
    properties (SetAccess=private)
        resonators resonator;
        summary_table=table();
    end
    
    methods 
        
        function obj=fit_resonators_group()
        
        addlistener(obj,'folder','PostSet',@(x,y)obj.folder_set_callback(x,y,obj));
        obj.prompt_folder;
        end
        
        function set.folder(obj,name)
            obj.folder=[];
            obj.folder=obj.gen_subfolders(name,obj.folder);
            %clear folders with no sparam
            
            formats=obj.format_files;
            tbrem=[];
            for k=1:length(obj.folder)
                folderfiles=dir(obj.folder(k));
                if ~any(contains(string({folderfiles.name}),formats))
                    tbrem=[tbrem,k];
                end
            end
            obj.folder(tbrem)=[];
        end
        
    end %Constructor, Setters, Getters, Destructors
    
    methods 
        
        prompt_folder(r);
        folders=gen_subfolders(r,name,folders);
        files=find_files(r,folder);
    end %Utils
    
    methods (Static) 
        folder_set_callback(src,event,obj);
    end % listeners callbacks
        
end
