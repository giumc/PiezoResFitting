function flag=run_optim(obj)

    problem.options                             =optimoptions('fmincon');
    
    problem.options.Display                     ='none';
    
    problem.options.MaxIterations               =50e3;
    
    problem.options.Algorithm                   ='interior-point';

%     problem.options.FiniteDifferenceType        ='central';
    
    problem.options.FunctionTolerance           =10;

    problem.options.StepTolerance               =1e-3;

%     problem.options.ConstraintTolerance         =1e-15;
    
    problem.options.OutputFcn                   =@(x,y,z) obj.out_optim(x,y,z);
    
    problem.options.UseParallel                 =false;

    problem.objective                           =@(x) obj.error_function(x);

    problem.x0                                  =[obj.get_opt_array.v];

    problem.lb                                  =zeros(1,length(problem.x0));
    
    problem.ub                                  =ones(1,length(problem.x0));

    problem.solver                              ='fmincon';
    
    obj.optimizer_setup                         =problem;
    
    obj.optimizer_setup.stop                    =0;
    
    [xa,~,flag]                                 =fmincon(obj.optimizer_setup);
    
    obj.transform_resonator(xa);
    
%     obj.update_fig;
    
end

