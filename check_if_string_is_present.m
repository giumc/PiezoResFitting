% flag=check_if_string_is_present(cell,str)
%
%   returns position of str in cell
%   returns false if not presetn

function flag=check_if_string_is_present(cell,str)

    flag=false;
    
    if iscell(cell) && length(cell)==1
        
        cell=string(cell{:});
        
    end
    
    if ~isempty(cell)
        
        for i=1:size(cell)
            
            if strcmp(cell{i},str)

                flag=i;

                return

            end
        
        end
   
    end
    
end
