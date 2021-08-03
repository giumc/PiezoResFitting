function dberr=get_error_db(obj)
 
    y_meas=obj.db(obj.y_meas);
    
    y_fit=obj.db(obj.get_y);
    
    for i=1:length(y_meas)
        
        dberr(i)=y_fit(i)-y_meas(i);
        
    end

end