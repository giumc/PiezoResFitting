function table_res(res)
    if ~isempty(res.values_table)
        if isa( res.values_table,'matlab.ui.control.Table') && isvalid(res.values_table)
            tab =   res.values_table;
        end
    else
        tab     =   uitable;
        res.values_table=tab;
    end
    
% switch circ.design.type
%     
%        case 'LCbandpass'
%         for k=1:length(circ.design.cell)
%                 RowN{1,k}=sprintf('cell');
%                 RowN{2,k}=sprintf(' fr [Hz]');
%                 RowN{3,k}=sprintf(' Q_L');
%                 Data1{1,k}=k;
%                 Data1{2,k}=circ.design.cell(k).fres;
%                 Data1{3,k}=circ.design.cell(k).q;
%         end
%         RowN2={'ModFreq [%]';'ModDepth [%]';'Load [Ohm]'};
%        previousFormat=get(0,'format');
%        format shortG
%        Data2={...
%            circ.modratio;circ.moddepth;...
%            circ.loadimpedance};
%        tab.RowName={RowN{~cellfun('isempty',RowN)},RowN2{:}};
%        tab.Data=[Data1{~cellfun('isempty',Data1)},Data2{:}].';
%        tab.ColumnName='Value';
%        format(previousFormat)   
% end
%     tab.Position(3:4)=tab.Extent(3:4);
%     tab.Position(1:2)=[0.5 0.1];
% circ.ui_tab=tab;
% end
end