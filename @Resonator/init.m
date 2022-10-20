function flag=init(r,varargin)

    flag=false;
    
    r.set_default_param;

    r.set_freq;

    addlistener(r,'touchstone_file','PostSet',@r.update_sparam);
    addlistener(r,'max_samples','PostSet',@r.update_sparam);
    addlistener(r,'smoothing_data','PostSet',@r.update_sparam);
    addlistener(r,'interp_points','PostSet',@r.update_sparam);  

    if ~isempty(varargin)
        
        flag=true;
        r.touchstone_file=varargin{1};
        r.touchstone_folder = fileparts(varargin{1});
        r.save_folder=r.touchstone_folder;
        r.guess_coarse;
        r.set_default_boundaries;

    else

        flag=r.prompt_touchstone;

    end
        
%         if flag
%             
%             r.save_folder=r.touchstone_folder;
%             
%         end


end
