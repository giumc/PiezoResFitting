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
                    r.setup_gui;
                    break
                case 6 %guess shape
                    r.guess_coarse;
                    r.update_fig;
                    break
                case 7 % Set boundaries
                    r.set_default_boundaries;
                    r.update_fig;
                    break
                case 8 % optimize all
                    for i=1:r.n_param
                        r.get_param(i).optimizable=true;
                    end
                    r.update_fig;
                case 9 %save
                    r.save_results;
                    
            end
        end
    end
        
end
