function p=plot_param(obj,Zparam,varargin)
    
    % pass a Zparam (from the fit table)
    % to be plotted on a 2D axis 
    % if varargin is specified, 
    % it has to be a row/column parameter list to plot on X,Y axis

    fig=figure;
    
    fig.Name=Zparam;
    
    elems=obj.get_map;
    
    for i=1:length(elems)
        
        X(i)=elems(i).pos(1);
        Y(i)=elems(i).pos(2);
        Z(i)=elems(i).fit_param.(Zparam);
        
    end
    
    if startsWith(Zparam,'kt2')
        
        Z=Z*100;
        
    end
    
    tab=table(X.',Y.',Z.');
    
    tab.Properties.VariableNames={'X','Y','Z'};
    
    p=heatmap(fig,tab,'X','Y','ColorVariable','Z');
    
    p.Title=Zparam;
    
    if startsWith(Zparam,'kt2')
        
        p.Title="k_t^2[%]";
        
    end
    
    p.CellLabelFormat='%0.3g';
    
end