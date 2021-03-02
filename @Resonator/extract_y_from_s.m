function extract_y_from_s(r)

adm_meas =[];

    if isempty(r.sparam)|| ~isa(r.sparam,'sparameters')
        
        return ;
        
    else
        ypar = yparameters(r.sparam);
        if r.sparam.NumPorts==1
            
            adm_meas = rfparam(ypar, 1, 1);
            
        end
        
        if r.sparam.NumPorts==2
            
            adm_meas = - rfparam(ypar, 2, 1);
            
        end
        
    end

    if length(adm_meas)>r.max_samples
        
        adm_meas = downsample(adm_meas,ceil(length(adm_meas)/r.max_samples));
    
    end
       
    r.y_meas    =   adm_meas;

    smoothing_index     =   r.smoothing_data;
    
    interp_points       =   r.interp_points;
    
%     r.y_smooth          =   medfilt1(real(r.y_meas),10)+...
%         1i*medfilt1(imag(r.y_meas),10);
    r.y_smooth          =   r.y_meas;
    
        if (smoothing_index==0&&interp_points==0) || isempty (r.y_smooth )
            
            return ;
        else
            
            if smoothing_index>0
                
                r.y_smooth    =   smooth(real(r.y_smooth ),...
                    smoothing_index) + ...
                        1i* smooth(imag(r.y_smooth ),smoothing_index) ;
            
            end
            
            if interp_points>0
                
                r.y_smooth =   interp1(...
                    r.freq,...
                    r.y_smooth,...
                    r.freq_smooth,...
                    'spline');
            end
                                 
        end
        
end

