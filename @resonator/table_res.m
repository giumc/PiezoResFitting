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
        for k=1:length(res.mode)
            Row1{1,k}=sprintf('mode');
            Row1{2,k}=sprintf('Fres [Hz]');
            Row1{3,k}=sprintf('kt2');
            Row1{4,k}=sprintf('Q');
            Data1{1,k}=k;
            Data1{2,k}=res.mode(k).fres;
            Data1{3,k}=res.mode(k).kt2;
            Data1{4,k}=res.mode(k).q;
        end
         Row2={'c0 [F]';'R0 [\omega]';'Rs [\oega]'};
        previousFormat=get(0,'format');
        format shortG
        Data2={...
            res.c0;res.r0;res.rs};
         tab.RowName={Row1{:},Row2{:}};
         tab.Data=[Data1{:},Data2{:}].';
         tab.ColumnName='Value';
         format(previousFormat)   
        tab.Position(3:4)=tab.Extent(3:4);
        tab.Position(1:2)=[0.6 0.5];

end
