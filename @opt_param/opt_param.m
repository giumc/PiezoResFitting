classdef opt_param < handle
    
    properties (SetAccess=private)
        value double ;
        min double;
        max double;
    end
    
    properties(SetAccess=private,Hidden)
        str_sci string;
        prefix string;       
    end
        
    properties
        label string;
        optimizable double;
        unit string;
    end
    
    methods
        
        function obj=opt_param(varargin)
            obj.value=0.5;
            obj.min=0;
            obj.max=1;
            obj.optimizable=true;
            obj.prefix='';
            obj.unit='';
            obj.label='Default';
            if ~isempty(varargin)
                if isnumeric(varargin{1})
                    obj.value   =   varargin{1};
                    obj.min     =   obj.value/2;
                    obj.max     =   obj.value*2;
                    obj.set_value(obj.value);
                end
            end
        end
        
    end %Constructor

    methods 
        
        normalize(obj);
        denormalize(obj);
        [scaled_values,label,exp] = num2str_sci(obj);
        
    end %Math
    
    methods
        set_value(obj,value);
        set_min(obj,value);
        set_max(obj,value);
    end% SET functions

end
