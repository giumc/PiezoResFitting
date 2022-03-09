function x0 = get_opt_array(obj)

    pars=obj.get_opt_params;

    opt_pars=pars([pars.optimizable]==1);

    v=arrayfun(@(x) x.normalize,opt_pars);

    i=find([pars.optimizable]==1);

    if ~isempty(v)

        x0(length(v))=struct('v',[],'i',[]);
        
    else
        
        x0=struct('v',[],'i',[]);
        
        return 
        
    end

    for k=1:length(v)

       x0(k).v=v(k);

       x0(k).i=i(k);

    end
   
end 
