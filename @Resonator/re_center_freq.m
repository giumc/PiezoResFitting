function re_center_freq(obj,fmin_new,fmax_new)
   % pass fmin and fmax to rescale measured data
   % a new sparameter will be associated to this resonator
   
    freq=obj.freq;

    if fmin_new>=fmax_new

        error("Pass fmin < fmax )");

    else

        if fmin_new>max(freq)||fmax_new<min(freq)

            error("Pass a vector within initial freq constraints");

        end

    end
    
    new_f=[];

    new_s=[];
    
    good_indexes=[];
    
    for i=1:length(freq)
        
        if freq(i)>=fmin_new && freq(i)<=fmax_new
            
            good_indexes=[good_indexes i];
      
        end
        
    end

    obj.sparam=sparameters(...
        obj.sparam.Parameters(:,:,good_indexes),...
        obj.freq(good_indexes));
    
    obj.set_freq;
    
    obj.extract_y_from_s;

end