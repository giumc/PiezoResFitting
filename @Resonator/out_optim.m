function stop   =     out_optim (res, x,~,state)

%     drawnow;
    stop=res.optimizer_setup.stop;
    tobedeactivated=[1 2 3 5 6 7 8]; %to deactivate buttons

    if strcmp(state,'init')

        if ~isempty(res.optim_checkbox)
            if isvalid(res.optim_checkbox)
                for i=1:length(tobedeactivated)

                    res.action_buttons(tobedeactivated(i)).Enable='off'; 

                end
                res.action_buttons(4).Enable='on';  %enable stop button
            end
        end

        if ~isempty(res.boundaries_edit)
            if isvalid([res.boundaries_edit{:}])
                for i=1:length(res.boundaries_edit)

                    edits=[res.boundaries_edit{i}];
                    edits(1).Enable='off';
                    edits(2).Enable='off';

                end
            end
        end

        if ~isempty(res.boundaries_bars)
            if isvalid(res.boundaries_bars)
                for i=1:length(res.boundaries_bars)

                    bar=res.boundaries_bars(i);
                    bar.Enable='off';

                end
            end
        end
        
        if ~isempty(res.optim_checkbox)
            if isvalid(res.optim_checkbox)
                for i=1:length(res.optim_checkbox)

                    c=res.optim_checkbox(i);
                    c.Enable='off';
                end
            end
        end
        
    end

    if stop==true
        res.optimizer_setup.stop=false;
        if ~isempty(res.action_buttons)
            if isvalid(res.action_buttons)

                res.action_buttons(4).Enable='off';
                res.action_buttons(3).Enable='on';
            end
        end
    end

    if strcmp(state,'iter')
        res.transform_resonator(x);
        res.update_fig;
        drawnow;
    end

    if strcmp(state,'done')||stop==true
        
        if ~isempty(res.boundaries_edit)
            if isvalid([res.boundaries_edit{:}])
                for i=1:length(res.boundaries_edit)
                    edits=[res.boundaries_edit{i}];
                    edits(1).Enable='on';
                    edits(2).Enable='on';
                end
            end
        end
        
        if ~isempty(res.boundaries_bars)
            if isvalid(res.boundaries_bars)
                for i=1:length(res.boundaries_bars)
                    bar=res.boundaries_bars(i);
                    bar.Enable='on';
                end
            end
        end
        
        if ~isempty(res.optim_checkbox)
            if isvalid(res.optim_checkbox)
                for i=1:length(res.optim_checkbox)
                    c=res.optim_checkbox(i);
                    c.Enable='on';
                end
            end
        end
        
        if ~isempty(res.optim_checkbox)
            if isvalid(res.optim_checkbox)
                for i=1:length(tobedeactivated)
                    res.action_buttons(tobedeactivated(i)).Enable='on'; 
                end
                res.action_buttons(4).Enable='off';  %disable stop button
            end
        end
        
    end
    
end
