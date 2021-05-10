function setup_optim_checkbox(r)

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
    
    pos_checkbox=@(i)[x0bars+dxbars+spacing+dxlabel y0bars-(i-1)*dybars];

%% add optimizable checkbox

    if (~isempty(r.optim_checkbox))
        
        delete(r.optim_checkbox)
        r.optim_checkbox=[];
        
    end
    
    for i=1:r.n_param
        c(i)=uicontrol();
        c(i).Parent=r.figure;
        c(i).Units='normalized';
        c(i).Style='radiobutton';
        c(i).Position([1,2])=pos_checkbox(i);
        c(i).Position([3,4])=[dylabel/3 dylabel];
        c(i).String='';%strcat('Test',num2str(i));
        c(i).Tag=r.param_name(i);
        c(i).Min=0;
        c(i).Max=1;
        c(i).Value=r.get_param(i).optimizable;
        c(i).BackgroundColor=rgb('GoldenRod');
        c(i).Callback={@r.checkbox_callback,r};
        c(i).Tag=r.param_name(i);
    end
    r.optim_checkbox=c;
    
    bars_per_column=r.bars_per_column+1;    

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    
    if r.n_param>bars_per_column
        for i=bars_per_column:r.n_param
            pos0=pos_checkbox(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            r.optim_checkbox(i).Position([1 2])=[x0 y0]+[dx 0];
        end
    end
