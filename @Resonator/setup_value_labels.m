function setup_value_labels(r)

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
    
    pos_value=@(i)[x0labels+dxlabel+spacing y0bars-(i-1)*dybars]; 
    
    %% add value labels
 
    if ~isempty(r.param_value_labels)
        if isobject(r.param_value_labels)&& all(isvalid(r.param_value_labels))
            delete(r.param_value_labels)
            r.param_value_labels=[];
        else
            r.param_value_labels=[];
        end
    end
    
    for i=1:r.n_param
        l2(i)=uicontrol();
        l2(i).Parent=r.figure;
        l2(i).Style='text';
        l2(i).Units='normalized';
        l2(i).FontSize=10;
        l2(i).BackgroundColor=rgb('LightGrey');
        l2(i).Position([3,4])=[dxlabel dylabel];
        l2(i).Position([1,2])=pos_value(i);
        opt_param=r.get_param(i);
        l2(i).String=opt_param.label;
        l2(i).Tag=l2(i).String;
%         unit =opt_param.unit;
%         if ~isempty(unit)
%             l2(i).String=strcat(l2(i).String,' [',unit,']');
%         else
%             l2(i).String=strcat(l2(i).String,' [',']');
%         end
    end
    r.param_value_labels=l2; 
    
    bars_per_column=r.bars_per_column+1;

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    
    if r.n_param>bars_per_column
        for i=bars_per_column:r.n_param
            %move value label
            pos0=pos_value(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            r.param_value_labels(i).Position([1 2])=[x0 y0]+[dx 0];
        end
    end
end
    
    
