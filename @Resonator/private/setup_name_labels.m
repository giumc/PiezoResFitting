function setup_name_labels(r)

    x0=r.x0fig;
    y0=r.y0fig;
    dxbars= r.dxbar;
    dybars= r.dybar;
    
    spacing=r.button_spacing;
    
    dxlabel = r.dxlabel;
    dylabel = r.dylabel;
    
    x0labels=r.x0label;
    y0labels=r.y0label;
    
    x0bars=r.x0bar;
    y0bars=r.y0label;

    dxcheckbox=r.checkbox_spacing;
    
    pos_name=@(i) [x0labels y0bars-(i-1)*dybars];
%% add name labels
 
    if ~isempty(r.param_name_labels)
        if isobject(r.param_name_labels)&& all(isvalid(r.param_name_labels))
            delete(r.param_name_labels)
            r.param_name_labels=[];
        else
            r.param_name_labels=[];
        end
    end
    
    for i=1:r.n_param
        l1(i)=uicontrol();
        l1(i).Parent=r.figure;
        l1(i).Style='text';
        l1(i).Units='normalized';
        l1(i).FontSize=10;
        l1(i).BackgroundColor=rgb('LightGrey');
        l1(i).Position([3,4])=[dxlabel dylabel];
        l1(i).Position([1,2])=pos_name(i);
        opt_param=r.get_param(i);
        l1(i).String=opt_param.label;
        
        l1(i).Tag=l1(i).String;
%         unit = opt_param.unit;
%         if ~isempty(unit)
%             l1(i).String=strcat(l1(i).String,' [',unit,']');
%         else
%             l1(i).String=strcat(l1(i).String,' [',']');
%         end
       
    end
    r.param_name_labels=l1;
    
    bars_per_column=r.bars_per_column+1;

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    
    if r.n_param>bars_per_column
        for i=bars_per_column:r.n_param
            %move labels
            pos0=pos_name(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            r.param_name_labels(i).Position([1 2])=[x0 y0]+[dx 0];
        end
    end
end
