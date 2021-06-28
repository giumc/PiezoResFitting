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
    
    pos=find(all((tab.MappingDim==idx).'), 1);
    
    layout_param=obj.layout_table(pos,:);
    
    fit_param=obj.fit_table(pos,:);
    
    elem.layout_param=layout_param;
   
    elem.fit_param=fit_param;
    
end