function guess_coarse(res)
    % finds initial points for fit:
    %   c0 is fitted from the measured datas
    %   r0 - rs are just taken from reasonable numbers;
    %   fres and q for all modes are taken from findpeaks() function;
    %   kt2 backcalculated from the antipeak for main mode,
            %and set to 0.1% for other mode
    %  NOTE:
    %  these values are also used as center points for the optimizer
    %  boundaries
    
    fprintf('\nResonator parameters estimation.\n');

    if isempty(res.y_meas)
        fprintf('No measured SParam was found,so no coarse fitting can be generated\n');
        return;
    else
        
        y_meas =    res.y_smooth;
    end
    
    if isempty(res.mode)
        fprintf('The resonator has no modes, use set_number_modes(X) method to add one\n');
        return
    end

    freq    =   res.freq;
    %from first mode, take peak from lincurve
    %so to get also q
    [~,i_max_1,q ] = findpeaks(abs(y_meas).^2,...
                'WidthReference','halfheight',...
                'SortStr','descend',...
                'NPeaks',max([1,length(res.mode)]));
    %for other modes, take peaks from dbcurve
    [~,i_max_2 ] = findpeaks(res.db(y_meas),...
            'SortStr','descend',...
            'MinPeakProminence',5,...
            'NPeaks',max([1,length(res.mode)]));
    i_max_1=i_max_1(1);
    i_max_2(1)=[];
    i_max=[i_max_1; i_max_2];
            
    [~,i_min] = findpeaks(res.db(1./y_meas),...
        'WidthReference','halfheight',...
        'SortStr','descend',...
        'NPeaks',1);
    
    res.set_default_param;
    res.c0  =   res.fit_c0;

            for i=1:length(i_max)
                if i==1
                    res.mode(i).fres        =   freq(i_max(i));

                    res.mode(i).q           =   q(i) * (freq(2)-freq(1));

                    res.mode(i).kt2         =   res.calculate_kt2(freq(i_max(1)),freq(i_min))/i;
                else
                    res.mode(i).fres        =   freq(i_max(i));

                    res.mode(i).q           =   1000;

                    res.mode(i).kt2         =   res.mode(1).kt2/10;
                end
            end
            
    res.r0                  =   1./ (2*pi*res.mode(1).fres*res.c0) / 0.01;

    res.rs                  =   1;
    
    res.set_default_boundaries;

end
