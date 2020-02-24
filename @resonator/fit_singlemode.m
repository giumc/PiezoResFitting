function fit_singlemode(res)

if isempty(res.sparam)
    return;
end

freq    =   res.freq;
if (res.smoothing_data==0)

    y_meas  =   res.y_meas;
else 
        y_meas = res.y_smooth;
end

[~,i_max,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',1);
            
c0_init     =   imag(y_meas(1))/(2*pi*freq(1));
c0_min      =   1/(2*pi*mean(freq))/c0_init/50;
c0_max      =   1/(2*pi*mean(freq))/c0_init*50;

fres_init   =   freq(i_max);
fres_max    =   max(freq);
fres_min    =   min(freq);

q_init      =   q * (freq(2)-freq(1));
q_min       =   10;
q_max       =   10e3;

kt2_init    =   res.calculate_kt2(freq(i_max),freq(i_min));
kt2_min     =   0;
kt2_max     =   1;

%continue from here

%F = @(x) sum(abs(Yfit(x) - Ydata)).^2;
% %F = @(x) sum(abs(20*log10(abs(Yfit(x))) - 20*log10(abs(Ydata)))).^2;
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

