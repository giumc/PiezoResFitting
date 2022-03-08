function setup_optim_text(obj)
    
    if ~isempty(obj.optim_text)

            delete(obj.optim_text);

            obj.optim_text=[];

    end
    
    if ~isempty(obj.figure)
        
        if isvalid(obj.figure)

            obj.optim_text=[];

            obj.optim_text=annotation(obj.figure,'textbox');

            obj.optim_text.FontName='Times New Roman';

            obj.optim_text.FontSize=obj.textfont;

            obj.optim_text.LineStyle='none';

            anchor=obj.mag_axis.Position;

            obj.optim_text.Position([1,2])=anchor([1,2])+anchor([3,4])-[obj.dx0optimtext obj.dy0optimtext];

            obj.optim_text.Position([3,4])=[obj.dx0optimtext obj.dy0optimtext];

        end
        
    end
end

