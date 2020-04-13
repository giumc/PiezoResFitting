classdef resonator_folder <handle

    %% properties
    
    properties (Constant,Access=private)
        format_files=[".s1p";".s2p";".S1P";".S2P"];
        result_tag='Fit_Result';
    end
    
    properties(SetObservable,AbortSet)
        folder char ;       
    end
     
    properties (SetAccess=private)
        resonators resonator;
        res_files;
    end
    
    %% methods
    
    methods 
        
        function obj=resonator_folder(varargin)
        
            addlistener(obj,'folder','PostSet',@(x,y)obj.folder_set_callback(x,y,obj));

             if ~isempty(varargin)
                if strcmp(varargin{1},'folder')
                    if length(varargin)>1
                    obj.folder=varargin{2};
                    end
                end
             else
                 obj.prompt_folder;
             end
        end
        
        function set.folder(obj,name)
        
            safestr=fileparts(which('fit_resonators_group.m'));   
            if isempty(name)
                fprintf("Wrong input, set to default folder\n");
                obj.folder=safestr;
            else
                if ~isfolder(name)
                    fprintf("Wrong input, set to default folder\n");
                    obj.folder=safestr;
                else
                    obj.folder=name;
                end
            end       
        end
        
    end %Constructor, Setters, Getters, Destructors
    
    methods
        prompt_folder(r);
        fit_all(r);
        save_results(r);
    end %main tools
    
    methods (Access=private) 
        
        files=find_files(r,folder);
        
        
    end %Utils
    
    methods (Static) 
        folder_set_callback(src,event,obj);
    end % listeners callbacks
        
end
