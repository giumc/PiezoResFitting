function setup_optim_text(r)
    r.optim_text=[];
    r.optim_text=annotation(r.figure,'textbox');
    r.optim_text.FontName='Times New Roman';
    r.optim_text.FontSize=r.textfont;
    r.optim_text.LineStyle='none';
    anchor=r.mag_axis.Position;
    r.optim_text.Position([1,2])=anchor([1,2])+anchor([3,4])-[r.dx0optimtext r.dy0optimtext];
    r.optim_text.Position([3,4])=[r.dx0optimtext r.dy0optimtext];
end

