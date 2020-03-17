function set_number_modes(res,n)
    n_new=ceil(n);
    
    n_old     =   length(res.mode);
    
    fprintf('\nChanging number of modes from %d to %d.\n',n_old,n_new);
    if n_old==0
        if n_new>0
            res.mode(1).fres=1e9;
            res.mode(1).kt2=0.1;
            res.mode(1).q=1e3;
            if n_new>=2
                for k=2:length(n_new)
                    res.mode(k)=res.mode(k-1);
                end
                res.guess_coarse;
            end
        return
        end
    end
    
    if n_new < n_old
        res.mode((n_new+1):n_old)=[];
    else    
        if n_new > n_old
            for k=n_old:1:(n_new-1)
                res.mode(k+1)=res.mode(k);
            end
        end 
    end
    res.guess_coarse;
    res.set_boundaries;
    fprintf('\nPlotting Data.\n');
    res.plot_data;
    fprintf('\nPlotting Table.\n');
    res.table_res;
end
