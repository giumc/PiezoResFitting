function print_all(obj,folder,varargin)
    
    obj.plot_param('FoM',varargin{:});
    myprint(gcf,folder);
    obj.plot_param('kt2_1',varargin{:});
    myprint(gcf,folder);
    obj.plot_param('Q_1',varargin{:});
    myprint(gcf,folder);
    obj.plot_param('Q_loaded',varargin{:});
    myprint(gcf,folder);
    obj.plot_param('Z0',varargin{:});
    myprint(gcf,folder);
    obj.plot_param('Fres_1',varargin{:});
    myprint(gcf,folder);
    map_obj=obj;
    save('map_data.mat','map_obj');

end