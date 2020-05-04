function setup_bars(r)

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
    
    pos_bars=@(i) [x0bars y0bars-dybars*(i-1) dxbars dybars];
       
    if (~isempty(r.boundaries_bars))
        delete(r.boundaries_bars)
        r.boundaries_bars=[];
    end
    
%% define bars
    for i=1:r.n_param
        b(i)=uicontrol();
        b(i).Parent=r.figure;
        b(i).Style='slider';
        b(i).Units='normalized';
        b(i).Position=pos_bars(i);
        b(i).SliderStep=[2.5e-3 5e-2];
        b(i).Min=0;
        b(i).Max=1;
        b(i).Value=0.5;
        opt_param=r.get_param(i);
        b(i).String=opt_param.label;
        b(i).Tag=b(i).String;
        b(i).BackgroundColor=r.rgb('LightCoral');  
        b(i).Callback={@r.bar_callback,r};
       
    end
    r.boundaries_bars=b; 
    
%% second column

    bars_per_column=r.bars_per_column+1;    

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    if r.n_param>bars_per_column
    %     
    %     %move labels
    %     labels2=copyobj(r.headings,r.figure);
    %     for i=1:length(labels2)
    %         labels2(i).Position([1 2])=labels2(i).Position([1 2])+[dx 0];
    %     end
    %     r.headings=[r.headings labels2.'];
    %     
        %move bars
        for i=bars_per_column:r.n_param

            %move bars
            pos0=pos_bars(mod(i+1,bars_per_column));
            x0=pos0(1);
            y0=pos0(2);
            r.boundaries_bars(i).Position([1,2])=...
                [x0 y0]+[dx 0];
        end
    end


end

