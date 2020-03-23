function setup_bars(r)

    x0=r.x0fig;
    y0=r.y0fig;
    dxbars= r.dxbar;
    dybars= r.dybar;
    
    spacing=r.button_spacing;
    
    dxlabel = r.dxlabel;
    dylabel = r.dylabel;
    
    x0labels=x0+r.dxfig-dxlabel/2;
    y0labels=y0+2*r.dyfig-3*dylabel;
    
    x0bars=x0labels+3*dxlabel+3*spacing;
    y0bars=y0labels;
    
    pos_bars=@(i) [x0bars y0bars-dybars*(i-1) dxbars dybars];
    pos_min=@(i)  [x0bars-dxlabel y0bars-(i-1)*dybars]; 
    pos_max=@(i)  [x0bars+dxbars y0bars-(i-1)*dybars];
    pos_name=@(i) [x0labels y0bars-(i-1)*dybars];
    pos_value=@(i)[x0labels+dxlabel+spacing y0bars-(i-1)*dybars];  
    pos_checkbox=@(i)[x0bars+dxbars+spacing+dxlabel y0bars-(i-1)*dybars];
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
        b(i).BackgroundColor=rgb('LightCoral');  
        b(i).Callback={@r.bar_callback,r};
       
    end
    r.boundaries_bars=b; 
    
%% define editable text (min / max) 
    
    if (~isempty(r.boundaries_edit))
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
p(6).Position([3 4])=[0.01 dylabel];
    r.headings=p;
        drawnow;
end
