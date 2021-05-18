classdef TFCapacitor < Resonator
    
   methods
       
       function obj=TFCapacitor(varargin)

           obj@Resonator(varargin{:});
           obj.r0.optimizable=false;
           obj.mode=[];
           obj.max_modes=0;
           
       end
       
       t=gen_table(obj);
   end
    
end