classdef resonator < handle
    
    properties
        touchstone_file;
        c0;
        r0;
        rs;
        mode;
        smoothing_data=0;
        max_samples = 20001;
    end
       
    properties (Dependent)     
        freq;
        y_calc;
        z_calc;
        sparam;
        y_meas;
        z_meas;
        y_smooth;
    end
    
    properties (Hidden, Dependent) 
        opt_boundaries;
    end%optimization
    
    properties (Hidden)
        figure;
        mag_axis;
        phase_axis;
        mag_legend;
        phase_legend;
        values_table;
    end %graphic
    
    methods 
        
        function obj =  resonator()
            obj.mode.fres   =   1e9;%default
            obj.mode.q      =   1000;%default
            obj.mode.kt2    =   0.05;%default
            obj.c0          =   1e-12;%default
            obj.r0          =   1e5;%default
            obj.rs          =   2;%default
        end
        
        function delete(obj)
            if isobject(obj.figure)
                delete(obj.figure)
            end        
        end
        
    end %Constructor/Destructor
    
    methods 
        prompt_touchstone(resonator);
        fit_multimode(resonator);
        c0  =   fit_c0(resonator);
        fit_res(resonator);
        guess_coarse(resonator);     
        y   =   error_function(resonator,x0);
        array_to_variables(resonator,x0);
        x0   = variables_to_array(resonator);
        stop    =   out_optim(resonator,x,flag,state);
    end %Tools
    
    methods
        setup_plot(resonator);
        plot_data(resonator);
        update_table(resonator);
    end %graphic

    methods (Static)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = normalize(x,xmin,xmax)
            if x<xmin || x>xmax
                fprintf('Out of Bounds!\n');
            else
            y   =   x ./ (xmax-xmin) - xmin ./ (xmax-xmin) ;
            end
        end

        function y = denormalize(x,xmin,xmax)
            if x<0 || x>1
                fprintf(' x is not normalized to 1 !\n');
            else
            y   =   xmin + x * (xmax - xmin) ;
            end
        end

        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
   
    end %Mathematical Functions
    
    methods 
        
        y   =   calculate_y (resonator);
        z   =   calculate_z (resonator);
        m   =   calculate_mot_branch(resonator,index);
        m   =   calculate_all_mot(resonator);
        y   =   extract_y_from_s(resonator);
        opt_boundaries =  set_boundaries(resonator);
        
    end % Tools for Dependent Definitions
    
    methods 
        
        function y  =   get.y_calc(resonator)
            y   =  calculate_y(resonator);
        end  
        
        function z  =   get.z_calc(resonator)
            z   =   calculate_z(resonator);
        end
     
        function f  =   get.freq(resonator)
            
            if isempty(resonator.touchstone_file)
                f   =  ( 0.9 : 0.001 : 1.1 ) *1e9 ;%default
            else
                f   =   resonator.sparam.Frequencies;
                if length(f)>resonator.max_samples
                    f   =   downsample(f, ceil(length(f)/resonator.max_samples));
                end
            end
        end
        
        function sparam   =   get.sparam(resonator)
            if isempty(resonator.touchstone_file)
                sparam      =    [];
            else
                sparam  =   sparameters(resonator.touchstone_file);
            end
        end
        
        function y_meas   =   get.y_meas(resonator)
            y_meas    =   extract_y_from_s(resonator);
        end
        
        function z_meas   =   get.z_meas(resonator)
            z_meas= [] ;
            if isempty(resonator.adm_meas)
                return ;
            else
                z_meas = 1./resonator.y_meas;
                return ;
            end
        end

        function y_smooth =   get.y_smooth(resonator)
            smoothing_index     =   resonator.smoothing_data;
            y_smooth              =   resonator.y_meas;
                if (smoothing_index==0) || isempty (y_smooth)
                    return ;
                else
                    y_smooth    =   smooth(real(y_smooth),smoothing_index) + ...
                            1i* smooth(imag(y_smooth),smoothing_index) ;
                end
        end
        
        function opt_boundaries     =   get.opt_boundaries(resonator)
                opt_boundaries = set_boundaries(resonator);
        end
                           
    end % Dependent Properties Definitions
           
end

