classdef resonator < handle
    
    properties
        touchstone_file;
        c0  =   1e-12;%default
        r0  =   1e5;%default
        rs  =   2;%default
        mode;
    end
    
    properties (Dependent)
        
        freq;
        y_calc;
        z_calc;
        sparam;
        mot_branch;
        
    end
    
    methods %Constructor
        
        function obj =  resonator()
            obj.mode.fres    =   1e9;%default
            obj.mode.qres    =   1000;%default
            obj.mode.kt2     =   0.05;%default
        end
    end
    
    methods % tools
        y   =   calculate_y (resonator);
        z   =   calculate_z (resonator);
        m  =    calculate_mot_branch(resonator,index);
    end
            
    methods % for dependent properties 
        
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
        
        function sparam     =   get.sparam(resonator)
            if isempty(resonator.touchstone_file)
                sparam      =    [];
            else
                sparam  =   sparameters(resonator.touchstone_file);
            end
        end
        
    end
    
end

