function found_tick=filter_sweep_param(...
    axis,layout_param,meas_index)

    measured_ticks=cellfun(@(x) str2num(x),meas_index);
        
    param_index=layout_param.index(:,axis);

    for i=1:length(measured_ticks)

        if ismember(measured_ticks(i),param_index)

            found_tick(i)=...
                layout_param.value(...
                param_index==measured_ticks(i));
        
        else

            error(strcat(...
                sprintf("param sweep %d",measured_ticks(i)),...
                 "was not matched in database"));

        end

    end
    
