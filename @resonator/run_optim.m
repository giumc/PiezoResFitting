function flag=run_optim(res)
%     clc
    
    
    problem.options                             =optimoptions('fmincon');
    problem.options.Display                     ='none';
    problem.options.MaxIterations               =50e3;
    problem.options.Algorithm                   ='interior-point';
%     problem.options.FiniteDifferenceType        ='central';
    problem.options.FunctionTolerance           =10;
    problem.options.StepTolerance               =1e-3;
%     problem.options.ConstraintTolerance         =1e-15;
    problem.options.OutputFcn                   =@(x,y,z) res.out_optim(x,y,z);
    problem.options.UseParallel                 =false;

    problem.objective                           =@(x) res.error_function(x);

    problem.x0                                  =res.get_optim_array;
    problem.lb                                  =zeros(1,length(problem.x0));
    problem.ub                                  =ones(1,length(problem.x0));

    problem.solver                              ='fmincon';
    
    
    res.optimizer_setup                         =problem;
    res.optimizer_setup.stop                    =0;
    
    [xa,~,flag]                                 =fmincon(res.optimizer_setup);
    res.transform_resonator(xa);
    res.update_fig;
    

end

