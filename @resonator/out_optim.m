function stop   =     out_optim (res, x,flag,state)
    drawnow;
    stop=res.optimizer_setup.stop;
    if stop==true
        res.optimizer_setup.stop=false;
        res.action_buttons(4).Enable='off';
        res.action_buttons(3).Enable='on';
    end
    
    if strcmp(state,'iter')
        res.transform_resonator(x);
        res.update_fig;
        drawnow;
    end
    
end
