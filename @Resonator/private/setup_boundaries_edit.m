function setup_boundaries_edit(r)
    
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
    
    pos_min=@(i)  [x0bars-dxlabel y0bars-(i-1)*dybars]; 
    pos_max=@(i)  [x0bars+dxbars y0bars-(i-1)*dybars];
    
    %% define editable text (min / max) 
    
    if ~isempty(r.boundaries_edit)
        t=[r.boundaries_edit{:}];
        delete(t);
        r.boundaries_edit=[];
    end
    
    for i=1:r.n_param
        t1(i)=uicontrol();
        t1(i).Parent=r.figure;
        t1(i).Style='edit';
        t1(i).Units='normalized';
        t1(i).FontSize=10;
        t1(i).String='0';
        t1(i).BackgroundColor=rgb('LightGreen');
        t1(i).Callback={@r.edit_callback,r};
        t1(i).Position([3,4])=[dxlabel dylabel];
        t1(i).Position([1,2])=pos_min(i);
        t2(i)=copyobj(t1(i),r.figure);
        t2(i).String='1';
        t2(i).Callback={@r.edit_callback,r};
        t2(i).Position([1,2])=pos_max(i);
        opt_param=r.get_param(i);
        t1(i).Tag=strcat(opt_param.label,'min');
        t2(i).Tag=strcat(opt_param.label,'max');
        r.boundaries_edit{i}=[t1(i) t2(i)];

    end

    bars_per_column=r.bars_per_column+1;

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    
    if r.n_param>bars_per_column
        for i=bars_per_column:r.n_param
            %move editable
            edits=r.boundaries_edit{i};
            min_edit=edits(1);
            max_edit=edits(2);
            pos0=pos_min(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            min_edit.Position([1,2])=[x0 y0]+[dx 0];
            pos0=pos_max(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            max_edit.Position([1,2])=[x0 y0]+[dx 0];
        end
    end
end
