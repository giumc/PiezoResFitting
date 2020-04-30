function fit_all(r)
r.progressbar('Fitting Resonators');
    for i=1:length(r.resonators)
        if ~isempty(r.resonators(i).touchstone_file)

            r.resonators(i).fit_all_modes;
            r.progressbar(i/length(r.resonators));
        end
    end
end
