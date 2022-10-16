function reset(r)
            
            while length(r.mode)>=1
                r.remove_mode;
            end

            r.respeak=[];
%             r.set_sparam;
%             r.set_freq;
%             r.extract_y_from_s;
            
            r.set_default_param;
            r.add_mode;
            r.guess_coarse;
            r.set_default_boundaries;
            r.isoptimized=0;

        end
