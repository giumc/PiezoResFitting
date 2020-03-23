function button_callback(caller,~,r)
   
    for i=1:length(r.buttons_name)
        
        if strcmp(r.buttons_name{i},caller.String)
            
            switch i
                case 1 %add mode
                    r.add_mode;
                    break
                case 2 %remove mode
                    r.remove_mode;
                    break
                case 3 %start fit
                    r.fit_routine;
                    break
                case 4 %stop_fit
                    r.optimizer_setup.stop=true;
%                     r.buttons_name(i).Enable='off';
                    break
                case 5 %reset
                    r.reset;
                    break
                case 6
                    r.guess_coarse;
                    r.update_fig;
                    break
                case 7
                    r.set_default_boundaries;
                    r.update_fig;
                    break
            end
        end
    end
    clc
    
end
