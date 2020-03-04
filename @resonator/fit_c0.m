function c0=fit_c0(res)

if isempty(res.sparam)
    return;
end


freq    =   res.freq;
y_meas  =   res.y_meas;

res.c0  =   imag(y_meas(1))/(2*pi*freq(1));

c0_min  =   res.boundaries.c0.min;
c0_max  =   res.boundaries.c0.max;

norm    =   @(x) res.normalize(x,c0_min,c0_max);
denorm  =   @(x) res.denormalize(x,c0_min,c0_max);

y_c0    =   @(x) 1i * 2 * pi * freq * x;

obj     =   @(x) sum(...
                    abs(res.db(y_c0(denorm(x)))...
                    -res.db((y_meas))).^2)/length(freq);
x0      =   norm(res.c0);

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
c0      =   denorm( fmincon(problem) );
res.c0  =   c0;
end
