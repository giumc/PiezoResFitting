function view_table(obj)

    fig=uifigure()
    fig.Units='normalized';
    fig.Position=[0.3 0.1 0.5 0.5];
    
    uitable(fig,'Data',obj.data_table);
   
end