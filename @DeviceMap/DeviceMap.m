classdef DeviceMap < handle 
   
   properties (Access=protected)
 
        chip_label string ="";
       
        wafer_label string ="";
        
        data_table table ;
        
   end
   
   properties (Access=protected) %Constants
       
       delimiters= ["x","_","X"];
       
   end
   
   methods 
       
       function obj=DeviceMap(l1,l2)
           
           obj.wafer_label=l1;
           obj.chip_label=l2;
           
       end
       
       load_table(obj,path);
       
       function test(obj)
           
          disp(obj.str2index('01x03.d2p'));
           
       end
       
       check_table(obj);
       
   end
   
   methods (Access=protected)
       
       cell=str2index(obj,tag);

   end
   
end