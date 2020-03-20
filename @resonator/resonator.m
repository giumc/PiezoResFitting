classdef resonator < handle
    
    properties (Hidden,SetObservable,AbortSet)
        max_samples = 20001;
        smoothing_data = 0;
    end%s-par modifiers
    
    properties (SetObservable,AbortSet)
        touchstone_file;
    end%vars w/ trigger
    
    properties (Access=private,Constant)
        x0norm= 0.7;
        y0norm= 0.9;
        dx= 0.2;
        dy= 0.03;
        dxlabel = 0.04;
        dylabel = 0.03;
    end %graphic positioners
    
    properties
        sparam;
        y_meas;
        y_smooth;
    end % measured vars
    
    properties (Dependent)
        y_calc;
    end% calculated when prompted
   
    properties (Dependent,Access=private)
        n_param;
    end% calcualted when prompted
    
    properties
        c0 opt_param;
        r0 opt_param;
        rs opt_param;
        mode = struct ('fres',opt_param,...
                       'q',opt_param,...
                       'kt2',opt_param);
        freq ;
    end % physical parameters
    
    properties (Hidden)
        figure;
        mag_axis;
        phase_axis;
        mag_legend;
        phase_legend;
        boundaries_bars;
        boundaries_edit;
        param_name_labels;
        param_value_labels;
    end % graphic objects
    
    methods 
        
        function obj =  resonator()
            obj.set_default_param;
            keyboard();
%             obj.set_freq;
            
%             addlistener(obj,'touchstone_file','PostSet',@obj.update_sparam);
%             addlistener(obj,'max_samples','PostSet',@obj.update_sparam);
%             addlistener(obj,'smoothing_data','PostSet',@obj.update_sparam);
%             
%             %to be removed
%             obj.touchstone_file='./Old optimization/Fitting test/R3C5_80MHz_140MHz_Pm20dB_vacuum.s2p';
%             obj.smoothing_data=5;
        end
        
        function delete(obj)
            if isobject(obj.figure)
                delete(obj.figure)
            end        
        end
        
    end %Constructor/Destructor
    
    methods (Access=private)
        
        array_to_variables(resonator,x0);
        x0      =   variables_to_array(resonator,x0);
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
        
        add_mode(resonator,varargin);
        remove_mode(resonator,varargin);
        
        set_param(resonator,index,value);
        num =   get_param(resonator,index);
        
        [min,max]   =   get_boundary(resonator,index);
        set_boundary(resonator,index,value,type);
        
    end % internal functions
    
    methods (Access=private,Static,Hidden)
        string  = get_param_name(index);
        string  = get_unit(index);
        num     = get_id_param(name);
        
    end % internal functions
    
    methods
        fit_routine(resonator);
        fit_resonance(resonator);
        guess_coarse(resonator);   
        
        function y = get.y_calc(resonator)
            y=calculate_y(resonator);          
            return;
        end
        
        set_default_param(resonator);
        set_default_boundaries(resonator);
        
        function n = get.n_param(resonator)
            n = length(resonator.mode)*3+3;
        end
    end % main tools
    
    methods
        setup_plot(resonator);
        plot_data(resonator);
        setup_bars(resonator);
        populate_bars(resonator);
        populate_boundaries_edit(resonator);
        populate_labels(resonator);
        update_fig(resonator);
    end % Graphic Tools

    methods (Static)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
        
        [value, exp] = str2num_sci(string);
    end %Mathematical Functions
   
    methods (Static)
        
        function update_sparam(~,event)
            res=event.AffectedObject;
            res.set_sparam;
            res.set_freq;
            res.extract_y_from_s;
        end
        
        bar_callback(src_event,event,resonator);       
        edit_callback(src_event,event,resonator);
        
    end %Listeners callback
    
end
