function p=plot_param(obj,Zparam,varargin)
    
    % pass a Zparam (from the fit table)
    % to be plotted on a 2D axis 
    % if varargin is specified, 
    % it has to be a row/column parameter list to plot on X,Y axis

    fig=gcf;
    
    delete(fig.Children);
    
    fig.Name=Zparam;
    
    elems=obj.get_map;
    
    for i=1:length(elems)
        
        X(i)=elems(i).pos(1);
        Y(i)=elems(i).pos(2);
        Z(i)=elems(i).fit_param.(Zparam);
        
    end
    
    if startsWith(Zparam,'kt2')
        
        Z=Z*100;
        
    else
        
        if startsWith(Zparam,'Fres')
            
           Z=Z/1e9;
            
        end
    
    tab=table(X.',Y.',Z.');
    
    tab.Properties.VariableNames={'X','Y','Z'};
    
    p=heatmap(fig,tab,'X','Y','ColorVariable','Z');
    
    p.Title=Zparam;
    
    if startsWith(Zparam,'kt2')
        
        p.Title="k_t^2[%]";
        
    else
 
        if startsWith(Zparam,'Fres')
            
            p.Title='Fres [GHz]';
        
        end
        
    end
    
    p.CellLabelFormat='%0.3g';
    
    if ~isempty(varargin)
        
        xlabel=varargin{1};
        
        ylabel=varargin{2};

        x_ticks=obj.get_sweep_param(1,xlabel);

        y_ticks=obj.get_sweep_param(2,ylabel);
        
        p.XDisplayLabels=obj.filter_sweep_param(1,...
            x_ticks,p.XDisplayData);
        
        p.XLabel=xlabel;

        p.YDisplayLabels=obj.filter_sweep_param(2,...
            y_ticks,p.YDisplayData);
        
        p.YLabel=ylabel;
        
    end
    
    p.MissingDataLabel='Missing';

end