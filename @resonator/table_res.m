function table_res(res)

    if isempty(res.figure)
        fprintf('Abort Table, no figure found\n');
        return
    else
        if ~isvalid(res.figure)
            fprintf('Abort Table, no figure found\n');
            return
        end
    end
    
    if ~isempty(res.values_table)
        if isa( res.values_table,'matlab.ui.control.Table') && isvalid(res.values_table)
            tab =   res.values_table;
        else
            tab     =   uitable;
            res.values_table=tab;
        end
    else
        tab     =   uitable;
        res.values_table=tab;
    end
    
       tab.Units='normalized';
       
%         [fres_tbp.values,fres_tbp.label,~]=samescale_magnitude([res.mode(:).fres]);
%         [kt2_tbp.values,kt2_tbp.label,~]=samescale_magnitude([res.mode(:).kt2]);
%         [q_tbp.values,q_tbp.label,~]=samescale_magnitude([res.mode(:).q]);
%         [c0_tbp.values,c0_tbp.label,~]=samescale_magnitude(res.c0);
%         [r0_tbp.values,r0_tbp.label,~]=samescale_magnitude(res.r0);
%         [rs_tbp.values,rs_tbp.label,~]=samescale_magnitude(res.rs);
        [fres_tbp.values,fres_tbp.label,~]=res.scale_magnitude([res.mode(:).fres]);
        [kt2_tbp.values,kt2_tbp.label,~]=res.scale_magnitude([res.mode(:).kt2]);
        [q_tbp.values,q_tbp.label,~]=res.scale_magnitude([res.mode(:).q]);
        [c0_tbp.values,c0_tbp.label,~]=res.scale_magnitude(res.c0);
        [r0_tbp.values,r0_tbp.label,~]=res.scale_magnitude(res.r0);
        [rs_tbp.values,rs_tbp.label,~]=res.scale_magnitude(res.rs);
        
        RowName{1}=strcat(sprintf('Fres'),{' ['},fres_tbp.label,{'Hz]'});
        RowName{2}=strcat({sprintf('kt2')},{' ['},kt2_tbp.label,{']'});
        RowName{3}=strcat({sprintf('Q')},{' ['},q_tbp.label,{']'});
        RowName{4}=strcat({sprintf('c0')},{' ['},c0_tbp.label,{'F]'});
        RowName{5}=strcat({sprintf('R0')},{' ['},r0_tbp.label,{'Ohm]'});
        RowName{6}=strcat({sprintf('Rs')},{' ['},rs_tbp.label,{'Ohm]'});
        previousFormat=get(0,'format');
        format shortG
        Data1(1,:)=[fres_tbp.values];
        Data1(2,:)=[kt2_tbp.values];
        Data1(3,:)=[q_tbp.values];
        Data1(4,:)=zeros(1,length(res.mode));
        Data1(5,:)=Data1(4,:);
        Data1(6,:)=Data1(5,:);
        
     Data2=[0;0;0;...
        c0_tbp.values;r0_tbp.values;rs_tbp.values];   
        tab.RowName=[RowName{:}];
        tab.Data=[Data2,Data1];
        column_names{1}='Value';
        for i=1:length(res.mode)
         column_names{i+1}=sprintf('Mode %d',i);
        end
        tab.ColumnName=column_names;
        format(previousFormat)   
        tab.Position(1:2)=[0.55 0.8];
        tab.Position(3:4)=tab.Extent(3:4);
        
%         function [norm_values,label,exp]=samescale_magnitude(values)
          
        
%         norm_values=values;
%         label='';
%         exp=0;
%         
%         for k=1:length(values)
%                 [values_tbp.value(k),...
%                     values_tbp.label{k},...
%                     values_tbp.exp(k)]...
%                     = res.scale_magnitude(values(k));
%         end
        
%         value_ref.value  =   values_tbp.value(1);
%         value_ref.label  =   values_tbp.label(1);
%         value_ref.exp    =   values_tbp.exp(1);
%         
%         for k=1:length(values)
%             if values_tbp.exp(k)==value_ref.exp
%                 norm_values(k)=values_tbp.value(k);
%             else
%                 norm_values(k)=values_tbp.value(k)*...
%                     10^(value_ref.exp-values_tbp.exp(k));
%             end
%         end
%         
%         label = value_ref.label;
%         exp   = value_ref.exp;
%         end
                

end
