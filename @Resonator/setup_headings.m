function setup_headings(r)

    
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
    
    %% add headings

    names=r.name_headings;

        if (~isempty(r.headings))

            delete(r.headings)
            r.headings=[];

        end

    for i=1:length(names)

        p(i)    =   uicontrol();
        p(i).Parent =   r.figure;
        p(i).Style  =   'text';
        p(i).Units  =   'normalized';
        p(i).FontSize = 10;
        p(i).BackgroundColor=rgb('LightBlue');
        p(i).Position([3 4])   = [dxlabel dylabel];
        p(i).String =   names{i};

    end

    p(1).Position=  [x0bars y0bars+dybars dxbars dybars];
    p(2).Position([1,2])=[x0bars-dxlabel y0bars+dybars];  
    p(3).Position([1,2])=[x0bars+dxbars y0bars+dybars];  
    p(4).Position([1,2])=[x0labels y0bars+dybars];  
    p(5).Position([1,2])=[x0labels+dxlabel+spacing y0bars+dybars];  
    p(6).Position([1,2])=[x0bars+dxbars+spacing+dxlabel y0bars+dybars];
    p(6).Position([3 4])=[dxcheckbox dylabel];
    r.headings=p;
    drawnow;
   
    end
        
