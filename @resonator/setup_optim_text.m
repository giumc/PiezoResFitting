function setup_optim_text(r)
    r.optim_text=[];
    r.optim_text=annotation(r.figure,'textbox');
    r.optim_text.FontName='Times New Roman';
    r.optim_text.FontSize=r.textfont;
    r.optim_text.LineStyle='none';
    r.optim_text.Position([1,2])=[r.x0optimtext r.y0optimtext];
end

