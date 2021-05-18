classdef Resonator < matlab.mixin.Copyable & handle
% -- Resonator class doc --
% used to read , fit and store Resonators with variable number of modes
% 
% properties:
% (*SETtable parameters*)
%     touchstone_file -> full path of sparameter file (S1P or S2P)
%         (*modifiers*)
%         max_samples -> to cap freq points (default 16001)
%         interp_points -> to increase freq points (default 0)
%         smoothing_data -> to filter out noisy points (default 0)
%         
%     max_modes   -> default 10
%     tag         -> name used to store (default based on touchstone)
%     save_folder 
%     
% (*GETtable parameters*)
%     sparam 
%     y_meas
%     y_calc
%     data_table
%     y_smooth    -> used as reference in fit
%     freq_smooth -> used as reference in fit
%     
% methods:
%     
%     fit_routine         -> fit Resonator, by adding one mode at a time
%     fit_all_modes       -> fit Resonator with all modes at the same time
%     guess_coarse        -> initial guess for Resonator shape (eqn based)
%     prompt_touchstone   -> UI to input touchstone file
%     setup_gui           -> open interactive UI
%     delete_gui          -> close interactive UI
%     save_results(opt)   -> save data
%           opt : 'printfig' , to include a fig file for each res
%     
        
    %% properties
    
    properties (Access=private)
        
        optimizer_setup;
        isoptimized=0;
        
    end % optimization options
   
    properties (SetObservable,AbortSet,Hidden)
        
        max_samples double = 16001;
        smoothing_data double = 0;
        interp_points double =  0;
        
    end %s-par modifiers
    
    properties(SetObservable,AbortSet)
        
        touchstone_file;
        
    end
    
    properties(Access=private)
        
        touchstone_folder;
        
    end
    
    properties
        
        tag='Default';
        save_folder;
        max_modes=10;
        
    end %output params
    
    properties (Constant,Access=private)
        
        dxfig=0.4;
        dyfig=0.35;
        x0fig=0;
        y0fig=0.3;
        
        dxbar= 0.075;
        dybar= 0.03;
        
        dxlabel = 0.04;
        dylabel = 0.03;
        
        dxbutton = 0.1;
        dybutton = 0.05;
        button_spacing = 0.001;
        checkbox_spacing = 0.01;
        
        x0label = Resonator.x0fig+Resonator.dxfig-Resonator.dxlabel/2;
        y0label = Resonator.y0fig+2*Resonator.dyfig-3*Resonator.dylabel;
        x0bar = Resonator.x0label+3*Resonator.dxlabel+3*Resonator.button_spacing;
        
        dx0optimtext=0.1;
        dy0optimtext=0.1;
        textfont=20;
        
        buttons_name={...
            "Add Mode",...
            "Remove Mode",...
            "Start Fit",...
            "Stop Fit",...
            "Reset",...
            "Guess Shape",...
            "Rescale Boundaries",...
            "OptimizeAll",...
            "Save"};
        name_headings={...
            "Control",...
            "Min",...
            "Max",...
            "Param",...
            "Value",...
            "O"};
        
        bars_per_column=30;
        
    end %graphic positioners
    
    properties (SetAccess=private)
        
        sparam;
        y_meas;
        data_table;
        outputfiles;
        
    end % measured vars
    
    properties (SetAccess=protected,Hidden)
        
        c0 OptParam;
        r0 OptParam;
        rs OptParam;
        mode = struct ('fres',OptParam,...
                       'q',OptParam,...
                       'kt2',OptParam);
        freq double;
        freq_smooth double;
        y_smooth double;
        respeak;
    end % physical parameters
    
    properties (Access=private)
        
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
        num_cols=1;
        optim_text;
        
    end % graphic objects

    %% methods 
    
    methods 
        
        function obj =  Resonator(varargin)
        
            if ~obj.init(varargin{:})
                
                obj.delete;
                
                error("Resonator Creation Failed\n");
                
            end
            
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
               
    end %Constructor/Destructor
    
    methods (Access=private,Hidden)
        
        flag=init(r,varargin);
        
        x0      =   get_optim_array(r);
        
        transform_resonator(r,x0);
        
        stop    =   out_optim(r,x,flag,state);
        
        err     =   error_function(r,x0); 
        
        y       =   get_y (r);
        
        flag    =   guess_mode(r,index);
        
        set_freq(r);
        
        set_sparam(r);

        extract_y_from_s(r);
        
        m   =   calculate_mot_branch(r,index); 
        
        m   =   calculate_all_mot(r);
        
        c0      =   fit_c0(r);
        
        flag    =   add_mode(r,varargin);
        
        remove_mode(r,varargin);
        
        set_param(r,index,value,varargin);
        
        num =   get_param(r,index);
        
        [min,max]   =   get_boundary(r,index);
        
        set_boundary(r,index,value,type);
        
        function y = n_param(r)
        
            y= length(r.mode)*3+3;
        
        end
        
        def_par=set_default_param(r,varargin);
        
        set_default_boundaries(r);
        
        flag=run_optim(r);
        
    end % internal functions
    
    methods (Static,Access=private) %const definition
        
        str= param_name(index);
        str= param_unit(index);
        n  = param_global_min(index) ;
        n  = param_global_max(index) ;
        
    end
    
    methods
        
        fit_routine(obj);
        
        fit_all_modes(obj);
        
        flag=prompt_touchstone(obj);

        f=setup_gui(obj,varargin);
        
        delete_gui(obj);
        
        output=save(obj,varargin);
        
        reset(obj);
        
        table=gen_table(r);
        
        flag=gen_spicenetlist(r);
        
        q=get_bode_q(r,varargin);
        
    end % main tools
    
    methods (Access=private)

        setup_plot(r,varargin);
        setup_bars(r);
        setup_boundaries_edit(r);
        setup_name_labels(r);
        setup_value_labels(r);
        setup_optim_checkbox(r);
        setup_optim_text(r);
        minimal_fig_setup(r);
        setup_headings(r);
        update_headings(r);
 
        plot_data(r);
        populate_bars(r);
        populate_boundaries_edit(r);
        populate_value_labels(r);
        populate_name_labels(r);
        populate_checkbox(r);
        populate_optim_text(r);
        update_fig(r);
        setup_buttons(r);
        
    end % Graphic Tools

    methods (Static,Access=private)
        
        function y = db(x)
            y = 20 .* log10 ( abs(x) );
        end
        
        function y = calculate_kt2(fseries,fshunt)
            y   =   pi* fseries/2/fshunt/(tan(pi*fseries/2/fshunt));
        end
        
        f=rgb(varargin);
        outcome=makefolder(folderpath,name);
        
    end %Generic Functions
   
    methods (Static,Access=private)
        
        function update_sparam(~,event)
            
            res=event.AffectedObject;
            [path,name]=fileparts(res.touchstone_file);
            msg=fprintf("Init of %s Resonator",name);
            res.save_folder=path;
            res.tag=regexprep(name,'.[sS][12][pP]','');
            res.set_sparam;
            res.set_freq;
            res.extract_y_from_s;
            res.guess_coarse;
            fprintf(repmat('\b',1,msg))
            
        end
        
        bar_callback(src_event,event,r);       
        edit_callback(src_event,event,r);
        button_callback(src_event,event,r);
        checkbox_callback(src_event,event,r);
        
    end %Listeners callback
    
end
