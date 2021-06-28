function pars=get_sweep_param(obj,varargin)
    
    if ~isempty(varargin)
        
        x_label=varargin{1};
        
        if length(varargin)>1
            
            y_label=varargin{2};
            
        else 
            
            y_label="";
        
        end
    
    else
        
        x_label="";
        
    end
    
end