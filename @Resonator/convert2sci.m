function str=convert2sci(num)
% convert2sci       -> return string with scientific notation
[scaled_val,label,~]=num2str_sci(num);

str=strcat(...
            sprintf('%.3f ',scaled_val),'',...
         label);
     
end
