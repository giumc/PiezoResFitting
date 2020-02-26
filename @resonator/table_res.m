function table_res(res)
    if ~isempty(res.values_table)
        if isa( res.values_table,'matlab.ui.control.Table') && isvalid(res.values_table)
            tab =   res.values_table;
        end
    else
        tab     =   uitable;
        res.values_table=tab;
    end
        tab.Units='normalized';
        Row1{1}=sprintf('Fres [Hz]');
        Row1{2}=sprintf('kt2');
        Row1{3}=sprintf('Q');
        for k=1:length(res.mode)
            
            Data1(1,k)=res.mode(k).fres;
            Data1(2,k)=res.mode(k).kt2;
            Data1(3,k)=res.mode(k).q;
            Data1(4:6,k)=0;
        end
         Row2={'c0 [F]';'R0 [Ohm]';'Rs [Ohm]'};
        previousFormat=get(0,'format');
        format shortG
        Data2=[0;0;0;
            res.c0;res.r0;res.rs];
         tab.RowName=[Row1(:)',Row2(:)'];
         tab.Data=[Data2,Data1];
         column_names{1}='Value';
         for i=1:length(res.mode)
             column_names{i+1}=sprintf('Mode %d',i);
         end
         tab.ColumnName=column_names;
         format(previousFormat)   
        tab.Position(3:4)=tab.Extent(3:4);
        tab.Position(1:2)=[0.6 0.5];

end
