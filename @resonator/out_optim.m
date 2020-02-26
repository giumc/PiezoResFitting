function stop   =     out_optim (res, x, flag,state)
    stop=false;
    if strcmp(state,'iter')
        res.array_to_variables(x);
        res.plot_data;
        res.table_res;
        pause(1)
    end
    
end