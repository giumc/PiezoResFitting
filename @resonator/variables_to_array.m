function x0 = variables_to_array(res)
   %x0 is made of:
   %c0
   %r0
   %rs
   %for each mode , there is 
   %fres
   %kt2
   %q
   
   x0 = 0.5* ones(1,res.n_param);
   for i=1:res.n_param
       [ min max ] = res.get_boundary(i);
       
       x0(i)    =   res.normalize(...
           res.get_param(i),min,max);
       
   end
   
   %don't optimize fres
   index_fres=[];
   for i=1:res.n_param
       if strcmp('Fres',res.get_param_name(i))
           index_fres=[ index_fres i];
       end
   end
   x0(index_fres)=[];
   
end 
