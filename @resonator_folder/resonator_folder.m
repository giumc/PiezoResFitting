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
    
    properties (Constant,Access=private)
        
        format_files=[".s1p";".s2p";".S1P";".S2P"];
    end
     
    properties (SetAccess=private)
        
        resonators resonator;
    end
    
    properties (Access=private)
        res_files;
        data_table;
        tag='_Fit_Result';
    end
    properties
        max_modes=10;
        folder;
    end
    
    %% methods
    
    methods 
        
        function obj=Resonator_folder(varargin)
        
            if ~isempty(varargin)
                for i=1:length(varargin)
                   if strcmp(varargin{i},'prompt')
                        obj.prompt_folder();
                        obj.read_all();
                   end
                end
            end
        end
        
    end %Constructor, Setters, Getters, Destructors
    
    methods
        
        folder=prompt_folder(r);
        flag=read_all(r);
        fit_all(r,varargin);
        save_all(r,varargin);
        inspect(r);
        
        function set.max_modes(r,value)
            r.max_modes=value;
            for i=1:length(r.resonators) %#ok<*MCSUP>
                r.resonators(i).max_modes=value;
            end
        end
        
    end %main tools
    
    methods (Access=private) 
        
        files=find_files(r,folder);      
        
    end %Utils
    
    methods (Static,Access=private) 
        
        progressbar(varargin);
        outcome=makefolder(folderpath,name);
        
    end 
        
end
