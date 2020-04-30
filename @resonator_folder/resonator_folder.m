classdef resonator_folder <handle
%
% Container for resonators in the same folder.
%   
% properties: 
%     folder (char array) -> Settable
%     resonators (resonator object) -> Gettable 
%     res_files -> Gettable
%     max_modes (int )-> Settable
%
% methods:
%     prompt_folder()     -> to input from UI resonators
%     fit_all()           -> fit all resonators in object
%     save_results(opt)   -> save data
%         opt : 'printfig' , to include a fig file for each res
%     
%    
% full path can be passed :
%     1) after specifier 'folder' when creating object;
%     2) if no specifier is passed to constructor, prompt is open
%         and folder can be selected from user interface;
%     3) manually setting it with obj.folder='...';
%
% once folder is set, the following are exec in auto:
%     1)array of resonator is created
%     2)resonators are fitted
%     3)datas are saved

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
        data_table;

    end
    
    properties
        max_modes=10;
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
        save_results(r,varargin);
 
    end %main tools
    
    methods (Access=private) 
        
        files=find_files(r,folder);      
        
    end %Utils
    
    methods (Static,Access=private) 
        
        folder_set_callback(src,event,obj);
        progressbar(varargin);
    end % listeners callbacks
        
end
