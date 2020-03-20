function stop   =     out_optim (res, x, flag,state)
    stop=false;
    if strcmp(state,'iter')
        res.array_to_variables(x);
        res.update_fig;
        drawnow
    end
    
end
