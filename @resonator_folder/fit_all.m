function fit_all(r)
    for i=1:length(r.resonators)
        if ~isempty(r.resonators(i).touchstone_file)
%             r.resonators(i).setup_gui;
            r.resonators(i).fit_all_modes;
%             r.resonators(i).delete_gui;
        end
    end
end
