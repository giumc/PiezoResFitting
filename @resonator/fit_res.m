function fit_res(res)
    
    problem.options                             =optimoptions('fmincon');
    problem.options.Display                     ='iter-detailed';
    problem.options.MaxFunctionEvaluations      =10e3;
    problem.options.MaxIterations               =50e3;
    problem.options.Algorithm                   ='interior-point';
    problem.options.FiniteDifferenceType        ='central';
    problem.options.FunctionTolerance           =1e-6;
    problem.options.StepTolerance               =1e-15;
    problem.options.OutputFcn                   =@(x,y,z) res.out_optim(x,y,z);

    problem.options.UseParallel                 =0;

    problem.objective                           =@(x) res.error_function(x);

    problem.x0                                  =res.variables_to_array;
    problem.lb                                  =zeros(1,length(problem.x0));
    problem.ub                                  =ones(1,length(problem.x0));

    problem.solver                              ='fmincon';
    
    xmin                                        =fmincon(problem);
    res.array_to_variables( xmin );
    res.plot_data;

end

