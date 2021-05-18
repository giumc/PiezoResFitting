classdef TFCapacitor_folder < Resonator_folder
    
    methods
        
        function obj=TFCapacitor_folder(obj,varargin)
            
            obj@Resonator_folder(varargin{:});
            
            obj.max_modes=0;
            
        end
        
        f=read_all(obj);
        
    end
    
end