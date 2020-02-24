function fit_singlemode(res)



% F = @(x) sum(abs(Yfit(x) - Ydata)).^2;
% F = @(x) sum(abs(20*log10(abs(Yfit(x))) - 20*log10(abs(Ydata)))).^2;
% F = @(x) sum(abs(angle(Yfit(x)) - angle(Ydata))).^2;
% 
% %% Optimization
% 
% %Initial guess
% x0 = [1 1 1 1];
% 
% %Other parameters
% A = [];                 %Matrix of linear inequalities unknown
% b = [];                 %Vector of known linear inequalities parameters
% Aeq = [];               %Matrix of linear equalities unknown
% beq = [];               %Vector of known linear inequalities parameters
% lb = zeros(4,1);        %Lower boundary (of each x(i))
% lb(4) = freq(1)./fsdummy;
% %ub = [];                %Upper boundary (of each x(i))
% ub = [10 10 10 freq(end)./fsdummy];
% 
% %Options
% options = optimset;
% options.OptimalityTolerance = 0.1e-15;
% 
% %Optimization
% [x, fval, ef, output, lambda] = fmincon(F, x0, A, b, Aeq, beq, lb, ub, [], options);
% 
% C0Fit = x(1)*C0dummy;
% QsFit = x(2)*Qsdummy;
% kt2Fit = x(3)*kt2dummy;
% fsFit = x(4)*fsdummy;
%% v1
% res.c0  =   res.fit_c0;
% 
% %possible better implementation for this is to write a fit_r0,
% %similarly to fit_c0
% res.r0  =   1 ./ 1e-7; 
% 
% res.rs  =   0;
% 
% %use findpeaks to find main peak
% 
% [~,i_max,q ] = findpeaks(abs(y_meas).^2,...
%                 'WidthReference','halfheight',...
%                 'SortStr','descend',...
%                 'NPeaks',1);
% [~,i_min ] =   findpeaks(abs(1./y_meas).^2,...
%                 'WidthReference','halfheight',...
%                 'SortStr','descend',...
%                 'NPeaks',1);
% 
% res.mode(1).fres    =   freq(i_max);
% res.mode(1).q       =   q * (freq(2)-freq(1));
% res.mode(1).kt2     =   res.calculate_kt2(freq(i_max),freq(i_min));

end

