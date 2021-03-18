function view_all(obj,varargin)

    res=obj.resonators;
    
    for i=1:length(obj.resonators)
        
        res(i).setup_gui(varargin{:});
        
        pause
        
        res(i).delete_gui;
        
    end
       
end
