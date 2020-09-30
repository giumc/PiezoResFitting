function x0 = get_optim_array(res)

   x0=[];
   
   for i=1:res.n_param
       
       name=res.param_name(i);
       
       opt_param=res.get_param(name);
       
       if opt_param.optimizable
           
            x0=[x0 opt_param.normalize];
            
       end
       
   end
   
end 
