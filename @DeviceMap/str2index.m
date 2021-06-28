function idx=str2index(obj,tag)

    if ~isstr(tag)
        
        if ischar(tag)
            
            tag=string(tag);
            
        else
            
            error(sprintf("%s%s\n","Tag is supposed to be a string,",...
                sprintf("you passed a %s",class(tag))));
            
        end
        
    end
        
    [~,tag,~]=fileparts(tag);

    delimiters=obj.delimiters;

    p=split(tag,delimiters);

    for i=1:length(p)

        try

            idx(i)=str2num(p{i});

        catch ME

            error(sprintf("Indexes could not be retrieved from %s",tag));

        end

    end
        
    end
    
    
            
            