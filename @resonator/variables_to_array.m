function x0 = variables_to_array(res)
   %x0 is made of:
   %c0
   %r0
   %rs
   %for each mode , there is 
   %fres
   %kt2
   %q
   
   bounds   =   res.opt_boundaries;
   x0(1)    =   res.normalize( res.c0, bounds.c0.min, bounds.c0.max);
  
   x0(2)    =   res.normalize( res.r0, bounds.r0.min, bounds.r0.max);
   
   x0(3)    =   res.normalize( res.rs, bounds.rs.min, bounds.rs.max);
   
   for i=1:length(res.mode)
       x0   =  [x0 res.normalize( res.mode(i).fres  , bounds.fres.min   , bounds.fres.max)  ];
       x0   =  [x0 res.normalize( res.mode(i).kt2   , bounds.kt2.min    , bounds.kt2.max)   ];
       x0   =  [x0 res.normalize( res.mode(i).q     , bounds.q.min      , bounds.q.max)     ];
   end
   
end 
