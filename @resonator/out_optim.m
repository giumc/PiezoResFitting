function stop   =     out_optim (res, x, flag,state)
    stop=false;
    if strcmp(state,'iter')
        res.array_to_variables(x);
        res.plot_data;
        pause(1)
    end
    
end