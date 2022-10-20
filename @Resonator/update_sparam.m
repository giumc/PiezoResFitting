function update_sparam(~,event)
            
    res=event.AffectedObject;
    [path,name]=fileparts(res.touchstone_file);
    msg=fprintf("Init of %s Resonator",name);
    res.save_folder=path;
    res.tag=regexprep(name,'.[sS][12][pP]','');
    res.set_sparam;
    res.set_freq;
    res.extract_y_from_s;
    res.guess_coarse;
    fprintf(repmat('\b',1,msg))

end