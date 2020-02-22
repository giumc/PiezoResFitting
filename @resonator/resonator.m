classdef resonator < handle
    
    properties
        touchstone_file;
        c0;
        r0;
        rs;
        mode;
        
        fit_results;
    end
    
    properties (Dependent)
        
        freq;
        y_calc;
        z_calc;
        sparam;
        y_meas;
        z_meas;
        
    end
    
    methods %Constructor
        
        function obj =  resonator()
            obj.mode.fres   =   1e9;%default
            obj.mode.q      =   1000;%default
            obj.mode.kt2    =   0.05;%default
            obj.c0          =   1e-12;%default
            obj.r0          =   1e5;%default
            obj.rs          =   2;%default
        end
        
    end
    
    methods % Tools
        
        y   =   calculate_y (resonator);
        z   =   calculate_z (resonator);
        m   =   calculate_mot_branch(resonator,index);
        assign_touchstone(resonator);
        m   =   calculate_all_mot(resonator);
        y   =   extract_y_from_s(resonator);
        x   =   error_function(resonator);
        fit_multimode(resonator);
        resplot(resonator);
    end
    
    methods (Static)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
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
        
    end
    
end

