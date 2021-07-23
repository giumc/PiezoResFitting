function elem=get_device(obj,varargin)
    % pass indexes, i.e. obj.get_device(1,2)
    %
    % returns a struct with fields:
    %   layout_param
    %   fit_param
    % both are tables with layout/fit parameters
        
    for i=1:length(varargin)
        
        idx(i)=varargin{i};
        
    end
    
    pos=find(all((obj.layout_table.MappingDim==idx).'), 1);
    
    if isempty(pos)
        
        error("Indexes not found in layout table");
        
    end
    layout_param=obj.layout_table(pos,:);
    
    pos=find(all((obj.fit_table.MappingDim==idx).'), 1);
    
    if isempty(pos)
        
        error("Indexes not found in fit table");
        
    end
    
    fit_param=obj.fit_table(pos,:);
    
    elem.layout_param=layout_param;
   
    elem.fit_param=fit_param;
    
end