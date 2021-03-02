function ret=setup_graphics(obj,fig,pos0)
    
    % ret=setup_graphics(obj,fig,pos0)
    %
    % sets up the UI for an OptParam 
    %
    % input parameters :
    %
    % fig   (parent figure)
    %
    % pos0 (coordinate of the upper left corner)
    %
    % returns array of UI handles:
    %
    % [name_label, min_label, slider,max_label,value]
    %
    % 
    obj.clear_graphics;
    
    dxbar=obj.dxbar;
    
    dxlabel=obj.dxlabel;
    
    dxname=1.5*obj.dxlabel;
    
    units=obj.units;
    textfont=obj.textfont;
    
    sliderstep=obj.sliderstep;
    obj.min_label=uicontrol('Style','text',...
        'Parent',fig','Units',units,'FontSize',textfont);
    obj.min_label.String='def_min';
    obj.min_label.Position=[pos0+[dxname 0] dxlabel obj.min_label.Extent(4)];
    
    obj.min_label.BackgroundColor=rgb("Grey");
    
    obj.slider=uicontrol('Style','slider',...
        'Parent',fig,'Units',units);
    obj.slider.SliderStep=sliderstep;
    obj.slider.Min=0;
    obj.slider.Max=1;
    obj.slider.Value=0;
    obj.slider.Position=([pos0+[dxlabel+dxname 0] dxbar obj.min_label.Extent(4)]);
    obj.slider.Callback=@obj.slider_callback;
    
    obj.max_label=uicontrol('Style','text',...
        'Parent',fig','Units',units,'FontSize',textfont);
    obj.max_label.Position=[pos0+[dxlabel + dxbar + dxname 0] dxlabel obj.min_label.Extent(4)];
    obj.max_label.String='def_max';
    obj.max_label.BackgroundColor=rgb("Grey");
    
    obj.name_label=uicontrol('Style','text',...
        'Parent',fig','Units',units,'FontSize',textfont);
    
    nametag=obj.label;
    
    if ~strcmp(obj.unit,"")
        nametag=strcat(obj.label," [",obj.unit,"]");
    end
    
    obj.name_label.String=nametag;
    obj.name_label.Position=[pos0 dxname obj.name_label.Extent(4)];
    
    obj.value_label=uicontrol('Style','text',...
        'Parent',fig','Units',units,'FontSize',textfont);
    obj.value_label.String='def_value';
    obj.value_label.Position=[pos0+[2*dxlabel + dxbar + dxname 0] dxname obj.min_label.Extent(4)];
    obj.value_label.BackgroundColor=rgb("Green");
    
    
    ret = [obj.name_label,obj.min_label,obj.slider,obj.max_label,obj.value_label];
    
end
