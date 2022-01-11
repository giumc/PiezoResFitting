function new=translate_fres(obj,df)

    new=copy(obj);
    
for i=1:length(obj.mode)
   
    new.mode(i).fres.set_value(obj.mode(i).fres.value+df,'override');
    
end

end