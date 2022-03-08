function x0 = get_opt_params(obj)
    
    x0=OptParam.empty(0,obj.n_param);
    
    for i=1:obj.n_param

       x0(i)=obj.get_param(obj.param_name(i));

    end
   
end 
