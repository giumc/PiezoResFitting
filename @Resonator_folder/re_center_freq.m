function re_center_freq(obj,fmin,fmax)
   
    
    for i=1:length(obj.resonators)
        
        obj.resonators(i).re_center_freq(fmin,fmax);
        
    end
    
end