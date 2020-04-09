function reset(r)
            
            while length(r.mode)>1
                r.remove_mode;
            end
            
            r.delete_gui();
            
            r.set_sparam;
            r.set_freq;
            r.extract_y_from_s;
            
            r.set_default_param;
            r.guess_coarse;
            r.set_default_boundaries;

        end
