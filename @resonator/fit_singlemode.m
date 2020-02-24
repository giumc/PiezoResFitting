function fit_singlemode(res)

if isempty(res.sparam)
    return;
end

freq    =   res.freq;
y_meas  =   res.y_meas;

res.c0  =   res.fit_c0;

%possible better implementation for this is to write a fit_r0,
%similarly to fit_c0
res.r0  =   1 ./ 1e-7; 

res.rs  =   0;

%use findpeaks to find main peak

[~,i_max,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',1);
[~,i_min ] =   findpeaks(abs(1./y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',1);

res.mode(1).fres    =   freq(i_max);
res.mode(1).q       =   q * (freq(2)-freq(1));
res.mode(1).kt2     =   res.calculate_kt2(freq(i_max),freq(i_min));

end

