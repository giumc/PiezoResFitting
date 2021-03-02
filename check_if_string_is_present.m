% flag=check_if_string_is_present(cell,str)
%
%   returns position of str in cell
%   returns false if not presetn

function flag=check_if_string_is_present(cell,str)

    flag=false;
    
    if ~isempty(cell)
        
        for i=1:length(cell)
            
            if iscell(cell)

                if strcmp(cell{i},str)
                    
                    flag=i;
                    
                    return
                    
                end
                
            else
                
                if isvec(cell)

                    if strcmp(cell(i),str)

                        flag=i;

                        return

                    end 
                    
                end
            
            end
            
        end
        
    end
    
end
