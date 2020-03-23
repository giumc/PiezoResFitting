classdef resonator < matlab.mixin.Copyable & handle
    
    %% properties
    properties %(Access=Private,Hidden)
        optimizer_setup;
    end % optimization options
    properties (Hidden,SetObservable,AbortSet)
        max_samples = 20001;
        smoothing_data = 0;
    end%s-par modifiers
    
    properties (SetObservable,AbortSet)
        touchstone_file;
    end%vars w/ trigger
    
    properties (Access=private,Constant)
        dxfig= 0.4;
        dyfig= 0.35;
        x0fig=0;
        y0fig=0.3;
        dxbar= 0.075;
        dybar= 0.03;
        dxlabel = 0.04;
        dylabel = 0.03;
        
        dxbutton = 0.1;
        dybutton = 0.05;
        button_spacing = 0.001;
        
        buttons_name={...
            "Add Mode",...
            "Remove Mode",...
            "Start Fit",...
            "Stop Fit",...
            "Reset to Default",...
            "Guess Shape",...
            "Rescale Boundaries"};
        name_headings={...
            "Control",...
            "Min",...
            "Max",...
            "Param",...
            "Value",...
            "O"};
    end %graphic positioners
    
    properties
        sparam;
        y_meas;
    end % measured vars
    
    properties (Dependent)
        y_calc;
    end% calculated when prompted
    
    properties %(Hidden)
        c0 opt_param;
        r0 opt_param;
        rs opt_param;
        mode = struct ('fres',opt_param,...
                       'q',opt_param,...
                       'kt2',opt_param);
        freq ;
        y_smooth;
    end % physical parameters
    
    properties %(Hidden)
        figure;
        mag_axis;
        phase_axis;
        mag_legend;
        phase_legend;
        boundaries_bars;
        boundaries_edit;
        param_name_labels;
        param_value_labels;
        action_buttons;
        optim_checkbox;
        headings;
    end % graphic objects

    %% methods 
    
    methods 
        
        function obj =  resonator()
            obj.set_default_param;
            obj.set_freq;
            
            addlistener(obj,'touchstone_file','PostSet',@obj.update_sparam);
            addlistener(obj,'max_samples','PostSet',@obj.update_sparam);
            addlistener(obj,'smoothing_data','PostSet',@obj.update_sparam);
%             
%             %to be removed
            obj.touchstone_file='./Old optimization/Fitting test/R3C5_80MHz_140MHz_Pm20dB_vacuum.s2p';
            obj.smoothing_data=5;
            obj.guess_coarse;
            obj.set_default_boundaries;
            obj.setup_plot;
            obj.setup_buttons;
            obj.setup_bars;
            obj.update_fig;
        end
        
        function delete(r)
            if ~isempty(r.figure)
                if isobject(r.figure)
                    if isvalid(r.figure)
                        delete(r.figure)
                    end
                end
            end        
        end
        
        reset(r);
        
    end %Constructor/Destructor
    
    methods %(Access=private)
        
        x0      =   optim_array(resonator);
        transform_resonator(resonator,x0);
        stop    =   out_optim(resonator,x,flag,state);
        err     =   error_function(resonator,x0);  
        y       =   calculate_y (resonator);
        guess_mode(resonator);
        set_freq(resonator);
        set_sparam(resonator);
        
        extract_y_from_s(resonator);
        m   =   calculate_mot_branch(resonator,index);     
        m   =   calculate_all_mot(resonator);
        prompt_touchstone(resonator);
        c0      =   fit_c0(resonator);
        
        add_mode(resonator,varargin);
        remove_mode(resonator,varargin);
        
        set_param(resonator,index,value,varargin);
        num =   get_param(resonator,index);
        
        [min,max]   =   get_boundary(resonator,index);
        set_boundary(resonator,index,value,type);
        
        function y = n_param(resonator)
            y= length(resonator.mode)*3+3;
        end
        
    end % internal functions
    
    methods (Static) %const definition
        str= param_name(index);
        str= param_unit(index);
    end
    
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
        
    end % main tools
    
    methods
        setup_plot(resonator);
        plot_data(resonator);
        setup_bars(resonator);
        populate_bars(resonator);
        populate_boundaries_edit(resonator);
        populate_labels(resonator);
        populate_checkbox(resonator);
        update_fig(resonator);
        setup_buttons(resonator);
    end % Graphic Tools

    methods (Static)%Access=private
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
        
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
        button_callback(src_event,event,resonator);
        checkbox_callback(src_event,event,resonator);
    end %Listeners callback
    
end
