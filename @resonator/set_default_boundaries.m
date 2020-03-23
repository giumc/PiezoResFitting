function set_default_boundaries(res)
    %fprintf('\nSetting default boundaries.\n');
    
    if isempty(res.y_meas)
        fprintf('Empty measure: No bounds generated\n');
        return;
    end
    down=0.5;
    up=1.5;
    res.c0.set_min(     res.c0.value*down    );
    res.c0.set_max(     res.c0.value*up      );
    
    res.r0.set_min(     res.r0.value*down     );
    res.r0.set_max(     res.r0.value*up       );

    res.rs.set_min(     res.rs.value*down     );
    res.rs.set_max(     res.rs.value*up       );
       
    for i=1:length(res.mode)
    
        res.mode(i).q.set_min(  down*...
                                res.mode(i).q.value   );
        res.mode(i).q.set_max(  up*...
                                res.mode(i).q.value   );
        
        res.mode(i).kt2.set_min(  down*...
                                res.mode(i).kt2.value   );
        res.mode(i).kt2.set_max(  up*...
                                res.mode(i).kt2.value   );
        
        res.mode(i).fres.set_min(  down*...
                                res.mode(i).fres.value   );
        res.mode(i).fres.set_max(  up*...
                                res.mode(i).fres.value   );
               
    end
    
end
