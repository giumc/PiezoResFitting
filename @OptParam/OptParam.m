classdef OptParam < matlab.mixin.Copyable & matlab.mixin.SetGet
    % optimizable parameter. 
    % inherits from matlab.mixin.Copyable and matlab.mixin.SetGet
    % 
    % ----- PROPERTIES ------
    % 
    % SetAccess-protected:
    % value
    % min
    % max
    % 
    % Access-protected:
    % global_max
    % global_min
    %
    % event :
    % ValueUpdate (if value is set)
    % 
    % Public:
    % optimizable (int32)    - > only 0 or 1
    % unit (string)
    % label (string)
    % rescale_factor    -> between 0 or 1
    %
    % Public , Hidden:
    % 
    % slider;           -> graphic handler
    % ----- METHODS -----
    %
    % Public:
    % set_value;
    % set_max;
    % set_min;
    % rescale_bounds     -> updates max/min as value*(1+/-f)
    
    
    %%
    
    events
        
       ValueUpdate; 
       
       GraphicUpdate;
       
    end
    
    %% properties
    
    properties (Access=private,Constant)
        
        def_value=0.5;
        def_min=0;
        def_max=1;
        def_global_max=1e20;
        def_global_min=0;
        def_label="Default";
        def_unit="";
        def_opt=true;
        def_rescale_factor=0.5;
        
        dxbar=0.2;
        dybar=0.04;
        dxlabel = 0.04;
        
        
        textfont=10;
        units='normalized';
        
        sliderstep=[0.01 0.02];
        
    end
    
    properties (SetAccess=protected)
        
        value double = OptParam.def_value;
        min double = OptParam.def_min;
        max double = OptParam.def_max;
        
    end
    
    properties (Access=protected)
        
        global_max double = OptParam.def_global_max;
        global_min double = OptParam.def_global_min;
        
    end
    
    properties
        
        label string = "Default";
        optimizable int32 = true;
        unit string = "";
        rescale_factor double = OptParam.def_rescale_factor;
        
    end
    
    properties (Access=private)
       
        slider matlab.ui.control.UIControl;
        min_label matlab.ui.control.UIControl;
        max_label matlab.ui.control.UIControl;
        value_label matlab.ui.control.UIControl;
        name_label matlab.ui.control.UIControl;
        
    end
    
    %% methods
    
    methods
        
        function obj=OptParam(varargin)
                    
            obj.init_param(varargin{:});
            
            addlistener(obj,'ValueUpdate',@(x,y) obj.update_graphics);
            
        end
        
        function delete(obj)
        
            obj.clear_graphics;
            
        end
        
        function varargout=summary(obj)
        
            str=sprintf('%10s \t =\t %8.2e',pad(obj.label,12),obj.value);
            
            if obj.optimizable
                
                str=strcat(str, ' (optimizable)\n');
                
            else
                
                str=strcat (str, '\n');
                
            end
            
            switch nargout
                
                case 0
                    
                    fprintf(str);
                    
                case 1
                    
                    varargout{1}=str;
                    
            end
            
        end
        
    end %Constructor

    methods 
        
        x = normalize(obj);
        x = denormalize(obj,x0);
        
        function set.optimizable(obj,value)
        
            if value==0 || value==1
                
                obj.optimizable=value;
                
            else
                
                error("optimizable property can be either 0 or 1");
                
            end
            
        end
        
        function set.rescale_factor(obj,value)
            
            if value>1 
                error("Bound scaling above 1 is not possible");
                
            else
                
                if value<0
                    error("Bound scaling below 0 is not possible");
                
                else
                
                    obj.rescale_factor=value;
                    
                    obj.rescale_bounds;
                    
                end
                    
            end
        
        end
        
        function rescale_bounds(obj,varargin)
        
            f=obj.rescale_factor;
            obj.set_min(obj.value*(1-f),varargin{:});
            obj.set_max(obj.value*(1+f),varargin{:});
            obj.update_graphics;

        end
        
        ret=setup_graphics(obj,fig,pos0);

        update_graphics(obj);
        
    end %Math
    
    methods
        
        set_value(obj,value,varargin);
        set_min(obj,value,varargin);
        set_max(obj,value,varargin);
        
    end %SET functions
    
    methods (Access=private)
        
        clear_graphics(obj);
        slider_callback(obj,src,event);
        
        init_param(obj,varargin);
        
    end

end
