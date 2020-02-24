function array_to_variables(res,x0)
   %x0 is made of:
   %c0
   %r0
   %rs
   %for each mode , there is 
   %fres
   %kt2
   %q

   bounds=res.opt_boundaries;
   z=0;
   res.c0   =   res.denormalize(x0(1),bounds.c0.min,bounds.c0.max);
   res.r0   =   res.denormalize(x0(2),bounds.r0.min,bounds.r0.max);
   res.rs   =   res.denormalize(x0(3),bounds.rs.min,bounds.rs.max);
   
   x0([1,2,3])= [];
   
   for i=1:length(res.mode)
       res.mode(i).fres     =   res.denormalize(x0(1),bounds.fres.min,bounds.fres.max);
       res.mode(i).kt2      =   res.denormalize(x0(2),bounds.kt2.min,bounds.kt2.max);
       res.mode(i).q        =   res.denormalize(x0(3),bounds.fres.min,bounds.fres.max);
       x0([1,2,3])=[];
   end
       
       
end