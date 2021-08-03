function val=get_max_error_db(obj)

    dberr=obj.get_error_db;
    
    val=max(dberr);
 
end