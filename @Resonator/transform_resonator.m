function transform_resonator(res,x0)

   j=1;
   
   for i=1:res.n_param  
       
       opt_param=res.get_param(i);
       
       if opt_param.optimizable
           
           opt_param.set_value(opt_param.denormalize(x0(j)));
           
           j=j+1;
           
       end
       
   end
           
end
