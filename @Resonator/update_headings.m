function update_headings(r)

    if ~isempty(r.headings)
        if ~isvalid(r.headings)
            return;
        end
    else
        return
    end
            
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
    
    bars_per_column=r.bars_per_column+1;    

    dx=4*dxlabel+dxbars+dxcheckbox+8*spacing;
    
    if r.n_param>bars_per_column
        if r.num_cols==1
            labels2=copyobj(r.headings,r.figure);
            for i=1:length(labels2)
                labels2(i).Position([1 2])=labels2(i).Position([1 2])+[dx 0];
            end
            r.headings=[r.headings labels2.']; 
            r.num_cols=2;
        end
    end
    
    if r.n_param<=bars_per_column
        if r.num_cols==2
            delete(r.headings((length(r.headings)/2+1):end));
            r.headings((length(r.headings)/2+1):end)=[];
            r.num_cols=1;
        end
    end
            
    
end
