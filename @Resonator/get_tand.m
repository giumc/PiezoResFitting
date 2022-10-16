function y=get_tand(obj)
    
   if isempty(obj.mode)
       
       y=obj@TFCapacitor.get_tand();
       
   else
       
       fres=obj.mode(1).fres.value;
       
       c0=obj.c0.value;

       z0=1/2/pi/fres/c0;

       r0=obj.r0.value;

       q=z0/r0;
       
       y=1/q;
   
   end
   
end