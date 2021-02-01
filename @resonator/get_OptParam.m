function x0 = get_OptParam(res)

   x0=[];
   
   for i=1:res.n_param
       
       name=res.param_name(i);
       
       opt_param=res.get_param(name);
       
       x0=[x0 opt_param];
       
   end
   
end 
