classdef Resonator_folder <handle
%
% Container for resonators in the same folder.
%   
% properties: 
%     folder (char array) -> Settable
%     resonators (resonator object) -> Gettable 
%     res_files -> Gettable
%     max_modes (int )-> Settable
%   
% properties (Hidden):
%    smoothing_data;
%    interp_points;
%
% methods:
%     prompt_folder()     -> opens UI to get folder containing resonators
%     fit_all()           -> fit all resonators objects
%     save_all(opt)       -> save data (type help for more info)
%         opt : 'printfig' , to include a fig file for each res
%     read_all()          -> initialize resonators in folder
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
    
    properties (Constant,Access=protected)
        
        format_files=[".s1p";".s2p";".S1P";".S2P"];
    end
     
    properties (SetAccess=protected)
        
        resonators Resonator;
        
    end
    
    properties (Access=protected)
        
        res_files ;
        
        tag='_Fit_Result';
        
        data_table table;
        
    end
    
    properties
        
        max_modes=10;
        
        folder;

    end
    
    properties (Hidden)
        
        smoothing_data double = 0;
        
        interp_points double =  0;
        
    end
    
    %% methods
    
    methods 
        
        function obj=Resonator_folder(varargin)
        
            pos_prompt=check_if_string_is_present(varargin,'prompt');
            
            if pos_prompt
                       
                obj.prompt_folder();

                obj.read_all();

            end
            
            pos_folder=check_if_string_is_present(varargin,'folder');
            
            if pos_folder
                       
                obj.folder=varargin{pos_folder+1};

                obj.read_all();

            end
        end
        
        function set.interp_points(obj,value)
           
            obj.interp_points=value;
            
            for i=1:length(obj.resonators)
                
                obj.resonators(i).interp_points=value;
                
            end
            
        end
        
        function set.smoothing_data(obj,value)
           
            obj.smoothing_data=value;
            
            for i=1:length(obj.resonators)
                
                obj.resonators(i).smoothing_data=value;
                
            end
            
        end
        
    end
   %Constructor, Setters, Getters, Destructors
    
    methods
        
        folder=prompt_folder(obj);
        
        flag=read_all(obj);
        
        fit_all(obj,varargin);
        
        flag=save_all(obj,varargin);
        
        inspect(obj);
        
        view_all(obj,varargin);
        
        reset(obj);
        
        t=gen_table(obj);
        
        function set.max_modes(obj,value)
            
            obj.max_modes=value;
            
            for i=1:length(obj.resonators) %#ok<*MCSUP>
                
                obj.resonators(i).max_modes=value;
                
            end
            
        end
        
        sort_by_tag(obj);
        
        res=find_by_tag(obj,tag);
        
        function x=get_resonators(obj)
            
            x=obj.resonators;
            
        end
        
    end %main tools
    
    methods (Access=protected) 
        
        files=find_files(obj,folder);      
        
    end %Utils
    
    methods (Static,Access=protected) 
        
        progressbar(varargin);
        
        outcome=makefolder(folderpath,name);
        
    end 
        
end
