classdef opt_param < matlab.mixin.Copyable % handle
    
    %% properties
    
    properties (SetAccess=private)
        value double;
        min double;
        max double;
    end
        
    properties
        label string;
        optimizable double;
        unit string;
    end
    
    %% methods
    
    methods
        
        function obj=opt_param(varargin)
            
            obj.override_value(0.5);
            obj.optimizable=true;
            obj.unit='';
            obj.label='Default';
            
            if ~isempty(varargin)
                if isnumeric(varargin{1})
                    obj.override_value(varargin{1});
                end
            end
            
        end
        
    end %Constructor

    methods 
        
        x = normalize(obj);
        x = denormalize(obj,x0);
        
    end %Math
    
    methods
        set_value(obj,value,varargin);
        set_min(obj,value);
        set_max(obj,value);
        override_value(obj,value);
        str= convert2sci(obj,num);
    end %SET functions
    
    methods (Static)
        [scaled_values,label,exp] = num2str_sci(num);
        num = str2num_sci(str);
    end
    
end
