function add_bars(r)
    
    %prevent override
    if (~isempty(r.boundaries_bars))
        return;
    end
    
    for i=1:(length(r.mode)*3+3)
        b(i)=uicontrol();
        b(i).Parent=r.figure;
        b(i).Style='slider';
        b(i).Units='normalized';
        b(i).Position=[ 0.06 i*0.04+0.02 0.3 0.05];
        b(i).Callback=@(x,y)callback_circbar(x,y,circ);
        b(i).String=sprintf('%1d',i);
        b(i).SliderStep=[2.5e-3 2.5e-2];
        b(i).Min=0;
        b(i).Max=1;
        b(i).Value=circ.optimizand(i);
    end
    
end
