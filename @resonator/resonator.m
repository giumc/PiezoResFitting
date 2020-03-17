classdef resonator < handle
    
    properties (Hidden,SetObservable,AbortSet)
        max_samples = 20001;
        smoothing_data = 0;
    end
    
    properties (SetObservable,AbortSet)
        touchstone_file;
        boundaries;
    end
    
    properties (SetAccess=private)
        sparam;
        y_meas;
        y_smooth;
    end
    
    properties (Dependent)
        y_calc;
    end
    
    properties
        c0          =   1e-12;%default
        r0          =   1e5;%default
        rs          =   2;%default;
        mode;
        freq        =   (0.9:0.0002:1.1)*1e9;
    end
    
    properties (Hidden)
        figure;
        mag_axis;
        phase_axis;
        mag_legend;
        phase_legend;
        values_table;
        boundaries_bars;
    end %graphic
    
    methods 
        
        function obj =  resonator()
            obj.set_number_modes(1);
            
            obj.mode.fres   =   1e9;%default
            obj.mode.q      =   1000;%default
            obj.mode.kt2    =   0.05;%default
            
            addlistener(obj,'touchstone_file','PostSet',@obj.update_sparam);
            addlistener(obj,'max_samples','PostSet',@obj.update_sparam);
            addlistener(obj,'smoothing_data','PostSet',@obj.update_sparam);
            addlistener(obj,'boundaries','PostSet',@obj.update_bounds);
            
        end
        
        function delete(obj)
            if isobject(obj.figure)
                delete(obj.figure)
            end        
        end
        
    end %Constructor/Destructor
    
    methods (Access=private, Hidden)
        array_to_variables(resonator,x0);
        stop    =   out_optim(resonator,x,flag,state);
        err     =   error_function(resonator,x0);  
        y       =   calculate_y (resonator); 
        set_freq(resonator);
        set_sparam(resonator);
        extract_y_from_s(resonator);
        m   =   calculate_mot_branch(resonator,index);     
        m   =   calculate_all_mot(resonator);
        prompt_touchstone(resonator);
        c0      =   fit_c0(resonator);
        add_bars(resonator);
    end
    
    methods
        
        fit_res(resonator);
        guess_coarse(resonator);   
        set_boundaries(resonator);
        function y = get.y_calc(resonator)
            y=calculate_y(resonator);          
            return;
        end
        set_number_modes(resonator,number);
         
    end % Object Tools
    
    methods
        setup_plot(resonator);
        plot_data(resonator);
        table_res(resonator);
    end % Graphic Tools

    methods (Static)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = normalize(x,xmin,xmax)
            y=0.5;
            if x<xmin || x>xmax
                fprintf(' x is Out of Bounds!\n');
                keyboard();
            else
            y   =   x ./ (xmax-xmin) - xmin ./ (xmax-xmin) ;
            end
        end

        function y = denormalize(x,xmin,xmax)
            y=xmin+0.5*(xmax-xmin);
            if x<0 || x>1
                fprintf(' x is not normalized to 1 !\n');
                keyboard();
            else
            y   =   xmin + x * (xmax - xmin) ;
            end
        end

        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
   
        [scaled_values,label,exp]= scale_magnitude(values);
    end %Mathematical Functions
   
    methods (Static)
        function update_sparam(~,event)
            res=event.AffectedObject;
            res.set_sparam;
            res.set_freq;
            res.extract_y_from_s;
            res.guess_coarse;
            res.set_boundaries;
            fprintf('\nPlotting Data.\n');
            res.plot_data;
            res.table_res;
        end
        
        function update_bounds(~,event)
            res=event.AffectedObject;
%             res.set_boundaries;
        end
        
    end %Listeners callback
    
end
