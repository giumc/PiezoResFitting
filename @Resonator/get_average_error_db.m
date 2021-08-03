function val=get_average_error_db(obj)
     
 
    dberr=obj.get_error_db;
    
    val=mean(dberr);
    
    
end