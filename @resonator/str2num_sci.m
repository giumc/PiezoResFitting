function num = str2num_sci(str)
% str2num(str)       -> returns [scaled value, prefix, exp] 
str=string(str);
errmsg=sprintf('\n Could not convert %s to number.\n',str);
num=str2double(str);
if ~isnan(num)
    return
end

prefix=["z","f","p","n","u","m","k","M","G","T"];
exponents=[-18 -15 -12 -9 -6 -3 3 6 9 12 15];

tags=zeros(length(prefix),1);
for i=1:length(prefix)
tags(i)= contains(str,prefix(i));
end
if ~any(tags)
    
    return
else
    [loc,n]=find(tags==1);
    if length(loc)~=1
        fprintf(errmsg);
    else
        string_mod=strrep(str,prefix(loc),"");
        num=str2double(string_mod);
        if isempty(num)
            fprintf(errmsg);
            return
        else
            num=num*10^(exponents(loc));
        end
    end
   
end
