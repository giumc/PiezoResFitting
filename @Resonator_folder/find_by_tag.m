function res=find_by_tag(obj,tag)

    all_res=obj.resonators;
    
    res=all_res(convertCharsToStrings({all_res.tag})==tag);

    if isempty(res)
       
        error("Cannot find anything with tag %s",tag);
        
    end
end