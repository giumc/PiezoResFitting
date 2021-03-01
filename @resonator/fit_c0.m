function c0=fit_c0(res)

c0      =   1e-12;

if isempty(res.sparam)
    
    return;
    
end

freq    =   res.freq_smooth;

y_smooth  =   res.y_smooth;

res.c0.set_value(abs(mean(imag(y_smooth))/2/pi/mean(freq)),'override');

res.c0.set_min(res.c0.value/10);

res.c0.set_max(res.c0.value*10);


y_c0    =   @(x) 1i * 2 * pi * freq * x;

obj     =   @(x) sum(...
                    abs(res.db(y_c0(res.c0.denormalize(x)))...
                    -res.db((y_smooth))).^2)/length(freq);
                
x0      =   res.c0.normalize;

options =   optimoptions('fmincon');

options.Algorithm='interior-point';

options.Display='none';

options.FiniteDifferenceType='central';

problem.lb=0;

problem.ub=1;

problem.objective=@(x) obj(x);

problem.solver='fmincon';

problem.x0=x0;

problem.options=options;

c0      =   res.c0.denormalize(( fmincon(problem) ));

res.c0.set_value(   c0  );

end
