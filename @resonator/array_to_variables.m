function array_to_variables(res,x0)
   %x0 is made of:
   %c0
   %r0
   %rs
   %for each mode , there is 
   %fres
   %kt2
   %q

   bounds=res.boundaries;
   res.c0   =   res.denormalize(x0(1),bounds.c0.min,bounds.c0.max);
   res.r0   =   res.denormalize(x0(2),bounds.r0.min,bounds.r0.max);
   res.rs   =   res.denormalize(x0(3),bounds.rs.min,bounds.rs.max);
   
   x0([1,2,3])= [];
   
   for i=1:length(res.mode)
       res.mode(i).fres     =   res.denormalize(...
           x0(1),bounds.mode(i).fres.min,bounds.mode(i).fres.max);
       res.mode(i).kt2      =   res.denormalize(...
           x0(2),bounds.mode(i).kt2.min,bounds.mode(i).kt2.max);
       res.mode(i).q        =   res.denormalize(...
           x0(3),bounds.mode(i).q.min,bounds.mode(i).q.max);
       x0([1,2,3])=[];
   end

       
       
end
