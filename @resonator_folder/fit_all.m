function fit_all(r)
    for i=1:length(r.resonators)
        if ~isempty(r.resonators(i).touchstone_file)
            r.resonators(i).fit_routine;
        end
    end
end
