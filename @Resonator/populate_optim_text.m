function populate_optim_text(obj)

    if ~isempty(obj.optim_text)
            
            if isvalid(obj.optim_text)
    
                obj.optim_text.String=sprintf('Modes:%d',length(obj.mode));
                
            end
            
    end
    
end
