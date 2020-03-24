function str=convert2sci(obj,num)

[scaled_val,label,~]=obj.num2str_sci(num);
str=strcat(...
            sprintf('%.1f ',scaled_val),'',...
         label);
     
end
