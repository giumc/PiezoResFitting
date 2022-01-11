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
        
        function delete(obj)
            
            if ~isempty(obj.figure)

                if isobject(obj.figure)

                    if isvalid(obj.figure)

                        delete(obj.figure)
                    end

                end

            end
        
        end
               
    end %Constructor/Destructor
    
    methods (Access=private,Hidden)
        
        flag=init(obj,varargin);
      
        x0      =   get_optim_array(obj);
        
        transform_resonator(obj,x0);
        
        stop    =   out_optim(obj,x,flag,state);
        
        err     =   error_function(obj,x0); 
        
        y       =   get_y (obj);
        
        flag    =   guess_mode(obj,index);
        
        set_freq(obj);
        
        set_sparam(obj);

        extract_y_from_s(obj);
        
        m   =   calculate_mot_branch(obj,index); 
        
        m   =   calculate_all_mot(obj);
        
        c0      =   fit_c0(obj);
        
        flag    =   add_mode(obj,varargin);
        
        remove_mode(obj,varargin);
        
        set_param(obj,index,value,varargin);
        
        num =   get_param(obj,index);
        
        [min,max]   =   get_boundary(obj,index);
        
        set_boundary(obj,index,value,type);
        
        function y = n_param(obj)
        
            y= length(obj.mode)*3+3;
        
        end
        
        def_par=set_default_param(obj,varargin);
        
        set_default_boundaries(obj);
        
        flag=run_optim(obj);
        
        dberr=get_error_db(obj);
        
        respeak=calc_respeak(obj);
        
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
        
        table=gen_table(obj);
        
        re_center_freq(obj,fvec);
        
        flag=gen_spicenetlist(obj,varargin);
        
        q=get_bode_q(obj,varargin);
        
        val=get_max_error_db(obj);
        
        val=get_average_error_db(obj);
        
        FoM=get_fom(obj,varargin);
        
        val=get_spurious_fom(obj);
        
        FoM=get_fom_with_rs(obj);
        
        Ql=get_qloaded(obj);
        
        Z0=get_Z0(obj);
        
        tand=get_tand(obj);
        
        function r=test(obj)
            
            r=obj.calc_respeak2;
            
        end
        
        s=get_MBVD_params(obj);
        
        new_res=transform_c0(obj,c0);
        
        new_res=translate_fres(obj,fres);

        end % main tools
    
    methods (Access=private)

        setup_plot(obj,varargin);
        setup_bars(obj);
        setup_boundaries_edit(obj);
        setup_name_labels(obj);
        setup_value_labels(obj);
        setup_optim_checkbox(obj);
        setup_optim_text(obj);
        minimal_fig_setup(obj);
        setup_headings(obj);
        update_headings(obj);
 
        plot_data(obj);
        populate_bars(obj);
        populate_boundaries_edit(obj);
        populate_value_labels(obj);
        populate_name_labels(obj);
        populate_checkbox(obj);
        populate_optim_text(obj);
        update_fig(obj);
        setup_buttons(obj);
        
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
        
        bar_callback(src_event,event,obj);       
        edit_callback(src_event,event,obj);
        button_callback(src_event,event,obj);
        checkbox_callback(src_event,event,obj);
        
    end %Listeners callback
    
end
