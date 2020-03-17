function add_bars(r)
    
    x0norm= 0.6;
    y0norm= 0.1;
    dx= 0.3;
    dy= 0.03;
    if (~isempty(r.boundaries_bars))
        delete(r.boundaries_bars);
    end
    %% define bars
    for i=1:r.n_param
        b(i)=uicontrol();
        b(i).Parent=r.figure;
        b(i).Style='slider';
        b(i).Units='normalized';
        b(i).Position=[x0norm y0norm+dy*(i-1) dx dy];
        b(i).SliderStep=[2.5e-3 2.5e-2];
        b(i).Min=0;
        b(i).Max=1;
        b(i).Value=0.5;
        b(i).String=assign_name(i);
        b(i).Tag=assign_name_order(i);
                    
        b(i).Callback={@r.bar_callback,r};
    end
    r.boundaries_bars=b; 
    %% define editable text
    
    if (~isempty(r.boundaries_edit))
        t=[r.boundaries_edit{:}];
        delete(t);
    end
    
    for i=1:r.n_param
        t1(i)=uicontrol();
        t1(i).Parent=r.figure;
        t1(i).Style='edit';
        t1(i).Units='normalized';
        t1(i).FontSize=10;
        t1(i).String='0';
        t1(i).BackgroundColor=rgb('LightGreen');
        t1(i).Position([3,4])=[0.04 0.03];
        t1(i).Position([1,2])=[x0norm-0.04 (i-1)*dy+y0norm];    
        t2(i)=copyobj(t1(i),r.figure);
        t2(i).String='1';
        t2(i).Position([1,2])=[x0norm+dx+0.02 (i-1)*dy+y0norm];
        t1(i).Tag=strcat(assign_name_order(i),'min');
        t2(i).Tag=strcat(assign_name_order(i),'max');
        r.boundaries_edit{i}=[t1(i) t2(i)];
    end
    
    %% add labels
 
    if ~isempty(r.param_labels)
        if isobject(r.param_labels)&& all(isvalid(r.param_labels))
            delete(r.param_labels)
        else
            r.param_labels=[];
        end
    end
    
    for i=1:r.n_param
        l1(i)=uicontrol();
        l1(i).Parent=r.figure;
        l1(i).Style='text';
        l1(i).Units='normalized';
        l1(i).FontSize=10;
        l1(i).BackgroundColor=rgb('LightGrey');
        l1(i).Position([3,4])=[0.04 0.03];
        l1(i).Position([1,2])=[x0norm-0.08 (i-1)*dy+y0norm];  
        l1(i).String=assign_name(i);
        l1(i).Tag=l1(i).String;
    end
    r.param_labels=l1;
    %% initial population
    bars=b;
    labels=l1;
    fprintf('\n Printing current Datas in Labels.\n');
    
for i=1:r.n_param
        switch i 
            case 1
                min=r.boundaries.c0.min;
                max=r.boundaries.c0.max;
                v=r.c0;
                unit='F';
            case 2
                min=r.boundaries.r0.min;
                max=r.boundaries.r0.max;
                v=r.r0;
                unit='Ohm';
            case 3
                min=r.boundaries.rs.min;
                max=r.boundaries.rs.max;
                v=r.rs;
                unit='Ohm';
            otherwise
                index=mod(i,3);
                n=floor((i-1)/3);
                boundmode=r.boundaries.mode(n);
                mode=r.mode(n);
                switch index
                    case 1
                        min=boundmode.fres.min;
                        max=boundmode.fres.max;
                        v=mode.fres;
                        unit='Hz';
                    case 2
                        min=boundmode.q.min;
                        max=boundmode.q.max;
                        v=mode.q;
                        unit='';
                    case 0
                        min=boundmode.kt2.min;
                        max=boundmode.kt2.max;
                        v=mode.kt2;
                        unit='';
                end
        end
        
            bars(i).Min=min;
            bars(i).Max=max;
            bars(i).Value=v;

         [scaled_min,min_label,~]=r.scale_magnitude(min); 
         [scaled_max,max_label,~]=r.scale_magnitude(max);
         %[scaled_v,v_label,v_exp]=r.scale_magnitude(min);
         
         edits=r.boundaries_edit{i};
         edits(1).String=strcat(...
             sprintf('%.0f%',scaled_min),'',...
             min_label);
         edits(2).String=strcat(...
             sprintf('%.0f%',scaled_max),'',...
             max_label);
         
         if ~strcmp(unit,'')
            labels(i).String=strcat(labels(i).Tag,' [',unit,']');
         else 
             labels(i).String=labels(i).Tag;
         end
    end

end
     function name=assign_name( k )
        
        name=[];
        switch k
                case 1
                    name='C0';
                case 2
                    name='R0';
                case 3
                    name='Rs';
            otherwise
                    n=mod(k,3);
                    switch n
                        case 1
                            name='Fres';
                        case 2
                            name='Q';
                        case 0
                            name='kt2';
                    end
        end
     end
     
     function name=assign_name_order(k)
        name=[];
        if k<=3
            name=assign_name(k);
        else
            mode=floor((k-1)/3);
            name=strcat(...
                assign_name(k),...
                sprintf('_%d',mode));
        end
     end
