function fom=get_fom(obj,varargin)

    fom=NaN;
    
    if isempty(varargin)
        
        i=1;
        
    else
        
        i=varargin{1};
        
    end
    
    if length(obj.mode)>=i

        q1=obj.mode(i).q.value;

        kt1=obj.mode(i).kt2.value;

            if ~any(isnan([kt1,q1]))

                fom=kt1*q1;
                
            end

    end

end