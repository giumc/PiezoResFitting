classdef opt_param < matlab.mixin.Copyable % handle
    
    %% properties
    
    properties (SetAccess=private)
        value double;
        min double = 0;
        max double = 1;
    end
    
    properties (Hidden)
        global_max double = 1e20;
        global_min double = 0;
    end
    
    properties
        label string;
        optimizable double;
        unit string;
    end
    
    %% methods
    
    methods
        
        function obj=opt_param(varargin)
            
            obj.set_value(0.5);
            obj.optimizable=true;
            obj.unit='';
            obj.label='Default';
            
            if ~isempty(varargin)
                if isnumeric(varargin{1})
                    obj.set_value(0.5,'override');
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
