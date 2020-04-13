function setup_buttons(r)

if ~isempty(r.action_buttons)
    if isvalid(r.action_buttons)
        delete(r.action_buttons)
        r.action_buttons=[];
    end
end


dx=r.dxbutton;
dy=r.dybutton;
spacing=r.button_spacing;
dy=dy+spacing;
dx=dx+spacing;
x0=r.x0fig+dx/3;
y0=r.y0fig-2*dy;
names=r.buttons_name;
for i=1:length(names)
    b(i)=uicontrol();
    b(i).Parent=r.figure;
    b(i).Units='normalized';
    b(i).Style='pushbutton';
    b(i).String=names{i};
    b(i).FontSize=10;
    b(i).Callback={@r.button_callback,r};
    b(i).Position([3,4])=[ dx dy];
end

spacing=r.button_spacing;
b(1).Position([1,2])=[x0 y0];
b(2).Position([1,2])=[x0+dx y0];
b(3).Position([1,2])=[x0 y0-dy];
b(4).Position([1,2])=[x0+dx y0-dy];
b(5).Position([1,2])=[x0 y0-2*dy];
b(6).Position([1,2])=[x0+dx y0-2*dy];
b(7).Position([1,2])=[x0+2*dx y0];
b(4).Enable='off';
b(8).Position([1 2])=[x0+2*dx y0-dy];
b(9).Position([1 2])=[x0+2*dx y0-2*dy];
r.action_buttons=b;
