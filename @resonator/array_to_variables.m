function array_to_variables(res,x0)
   %x0 is made of:
   %c0
   %r0
   %rs
   %for each mode , there is 
   %fres
   %kt2
   %q

   %add unoptimized Fres
   insert = @(a, x, n) cat(2,  x(1:n), a, x(n+1:end));
   
   for i=1:res.n_param
       if strcmp('Fres',res.get_param_name(i))
           [ min max ] = res.get_boundary(i);
           x0=insert(res.normalize(res.get_param(i),min,max),...
                     x0,i-1);
       end
   end
   
   for i=1:res.n_param
       [ min max ] = res.get_boundary(i);
       
        res.set_param(i,res.denormalize(x0(i),min,max));
       
   end
  
   
end
