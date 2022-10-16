function re_center_freq(obj,fmin_new,fmax_new)
    
    old_f=obj.freq;
    
    old_spar=obj.sparam;

    if fmin_new>=fmax_new

        error("Pass fmin < fmax )");

    else

        if fmin_new>max(old_f)||fmax_new<min(old_f)

            error("Pass a vector within initial freq constraints");

        end

    end
    
    new_f=[];

    new_s=[];
    
    for i=1:length(old_f)
        
        if old_f(i)>=fmin_new && old_f(i)<=fmax_new
            
            new_f=[new_f old_f(i)];
            
            new_s=[new_s old_spar.Parameters(:,:,i)];
            
        end
        
    end
    
    obj.freq=new_f;
    
    obj.sparam=sparameters(new_s,new_f,obj.sparam.Impedance);
    
    obj.set_freq;
    
    obj.extract_y_from_s;

end