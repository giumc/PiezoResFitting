function print_all(obj,folder,varargin)
%    function print_all(obj,folder,varargin)
%        
%       saves all relevant chipmap plots to folder
%       pass varargin to plot_param
%       parameters saved:
%       FoM_with_Rs
%       kt2_1
%       Q_1
%       Q_loaded
%       Z0
%       Fres_1
%
%       then saves map_data in folder for further analysis
    obj.plot_param('FoM',varargin{:});
    fig=gcf;
    fig.WindowState='maximized';
    myprint(gcf,folder);
    obj.plot_param('FoM_with_Rs',varargin{:});
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