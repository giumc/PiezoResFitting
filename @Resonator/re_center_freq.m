function re_center_freq(obj,fvec)

    while length(obj.mode)>=1
        
        obj.remove_mode;
    
    end
    
    if isempty(obj.touchstone_file)
        
        error("Initialize touchstone_file first");
        
    end
    
    old_f=obj.freq;
    
    old_spar=obj.sparam;
    
    if ~(length(fvec)==2)
        
        error("Pass a vector with [fmin fmax])");
        
    else
        
        fmin_new=fvec(1);
        
        fmax_new=fvec(2);
        
        if fmin_new>=fmax_new
        
            error("Pass fmin < fmax )");
            
        else
            
            if fmin_new>max(old_f)||fmax_new<min(old_f)
                
                error("Pass a vector within initial freq constraints");
                
            end
            
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
    
    obj.respeak=[];
    
    obj.extract_y_from_s;

    obj.set_default_param;
    
    obj.add_mode;
    
    obj.guess_coarse;
    
    obj.set_default_boundaries;
    
end