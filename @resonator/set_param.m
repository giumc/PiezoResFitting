function set_param(r,param,value,varargin)

    if isempty(param)
        
        fprintf('\nCannot set parameter\n');
        
    end

    override_tag='';
    
    if ~isempty(varargin)
        
        if strcmp(varargin{1},'override')
            
            override_tag='override';
            
        end
    end
    
    %cap params
    
    param.set_value(value,override_tag);
    
end
