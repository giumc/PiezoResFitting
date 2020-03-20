function fit_routine(r)

loop=true;
iter=0;
r.set_number_modes(1);
r.guess_coarse;
while loop
    r.fit_resonance;
    iter=iter+1;
    err(iter)     = r.error_function (r.variables_to_array);
    
    r.set_number_modes(length(r.mode)+1);
    r.guess_coarse;
    
    if iter==8
        loop=false;
    end
end

end
