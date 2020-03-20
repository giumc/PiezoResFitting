function setup_bars(r)

    x0norm= r.x0norm;
    y0norm= r.y0norm;
    dx= r.dx;
    dy= r.dy;
    
    dxlabel = r.dxlabel;
    dylabel = r.dylabel;
    
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
        b(i).Position=[x0norm y0norm-dy*(i-1) dx dy];
        b(i).SliderStep=[2.5e-3 5e-2];
        b(i).Min=0;
        b(i).Max=1;
        b(i).Value=0.5;
        b(i).String=r.get_param_name(i);
        b(i).Tag=assign_name_order(r,i);
        b(i).BackgroundColor=rgb('LightCoral');  
        b(i).Callback={@r.bar_callback,r};
        
        if i==r.n_param %define heading
            
            p(1)    =   uicontrol();
            p(1).Parent =   r.figure;
            p(1).Style  =   'text';
            p(1).Units  =   'normalized';
            p(1).FontSize = 10;
            p(1).BackgroundColor=rgb('LightBlue');
            p(1).Position   =   [x0norm y0norm+dy dx dy];
            p(1).String =   'Control';
        end
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
        t1(i).Position([1,2])=[x0norm-dxlabel y0norm-(i-1)*dy];    
        t2(i)=copyobj(t1(i),r.figure);
        t2(i).String='1';
        t2(i).Callback={@r.edit_callback,r};
        t2(i).Position([1,2])=[x0norm+dx y0norm-(i-1)*dy];
        t1(i).Tag=strcat(assign_name_order(r,i),'min');
        t2(i).Tag=strcat(assign_name_order(r,i),'max');
        r.boundaries_edit{i}=[t1(i) t2(i)];
        
        if i==r.n_param %define heading
            
            p(2)=   copyobj(p(1),r.figure);
            
            p(2).Position([3,4])=[dxlabel dylabel];
            p(2).Position([1,2])=[x0norm-dxlabel y0norm+dy];  
            p(2).String =   'Min';
            
            p(3)=   copyobj(p(1),r.figure);
            p(3).Position([3,4])=[dxlabel dylabel];
            p(3).Position([1,2])=[x0norm+dx y0norm+dy];  
            p(3).String =   'Max';
            
        end
        
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
        l1(i).Position([1,2])=[x0norm-4*dxlabel y0norm-(i-1)*dy];  
        l1(i).String=r.get_param_name(i);
        l1(i).Tag=l1(i).String;
        unit = r.get_unit(i);
        if ~isempty(unit)
            l1(i).String=strcat(l1(i).String,' [',unit,']');
        else
            l1(i).String=strcat(l1(i).String,' [',']');
        end
        
        if i==r.n_param %define heading
            
            p(4)= copyobj(p(1),r.figure);
            p(4).Position([3,4])=[dxlabel dylabel];
            p(4).Position([1,2])=[x0norm-4*dxlabel y0norm+dy];  
            p(4).String =   'Param';
            
            p(5)= copyobj(p(1),r.figure);
            p(5).Position([3,4])=[dxlabel dylabel];
            p(5).Position([1,2])=[x0norm-2.5*dxlabel y0norm+dy];  
            p(5).String =   'Value';
            
        end
    end
    r.param_name_labels=[l1 p]; 
    
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
        l2(i).Position([1,2])=[x0norm-2.5*dxlabel y0norm-(i-1)*dy];  
        l2(i).String=r.get_param_name(i);
        l2(i).Tag=l2(i).String;
        unit =r.get_unit(i);
        if ~isempty(unit)
            l2(i).String=strcat(l2(i).String,' [',unit,']');
        else
            l2(i).String=strcat(l2(i).String,' [',']');
        end
    end
    r.param_value_labels=l2; 
end
%% adds mode number to name 
function name=assign_name_order(r,k)
    name=[];
    if k<=3
        name=r.get_param_name(k);
    else
        mode=floor((k-1)/3);
        name=strcat(...
            r.get_param_name(k),...
            sprintf('_%d',mode));
    end
end
