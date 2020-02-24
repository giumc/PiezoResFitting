classdef resonator < handle
    
    properties
        touchstone_file;
        c0;
        r0;
        rs;
        mode;
        smoothing_data=0;
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
    
    properties (Hidden)
        figure;
        mag_axis;
        phase_axis;
        mag_legend;
        phase_legend;
    end
    
    methods %Constructor/Destructor
        
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
        
    end
    
    methods %Tools

        prompt_touchstone(resonator);
        x   =   error_function(resonator);
        fit_multimode(resonator);
        setup_plot(resonator);
        plot_data(resonator);
        c0  =   fit_c0(resonator);
        fit_singlemode(resonator);

    end

    methods (Static)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = normalize(x,xmin,xmax)
            y   =   x ./ (xmax-xmin) + xmin ./ (xmax-xmin) ;
        end

        function y = denormalize(x,xmin,xmax)
            y   =   xmin + x * (xmax - xmin) ;
        end

        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
   
 end %Mathematical Functions
    
    methods % Tools for Dependent Definitions
        
        y   =   calculate_y (resonator);
        z   =   calculate_z (resonator);
        m   =   calculate_mot_branch(resonator,index);
        m   =   calculate_all_mot(resonator);
        y   =   extract_y_from_s(resonator);
    end

    methods % Dependent Properties Definitions
        
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
                    
    end
        
        
    
end

