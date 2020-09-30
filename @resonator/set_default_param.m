function def_par=set_default_param(r,varargin)

    def_par=OptParam();
    i=1;
    
    c0 = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    c0.set_value(100e-15,'override');
    
    c0.label=r.param_name(i);
    
    c0.unit=r.param_unit(i);
    
    i=2;
    
    r0 = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    r0.set_value(100e3,'override');
    
    r0.label=r.param_name(i);
    
    r0.unit=r.param_unit(i);
    
    i=3;
    
    rs = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    rs.set_value(1,'override');
    
    rs.label=r.param_name(i);
    
    rs.unit=r.param_unit(i);
    
    i=4;
    
    mode.fres = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    mode.fres.set_value(1e9,'override');
    
    mode.fres.label=r.param_name(i);
    
    mode.fres.unit=r.param_unit(i);
    
    i=5;
    
    mode.q = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    mode.q.set_value(1e3,'override');
    
    mode.q.label=r.param_name(i);
    
    mode.q.unit=r.param_unit(i);
    
    i=6;
    
    mode.kt2 = OptParam(1,...
        'global_min',r.param_global_min(i),...
        'global_max',r.param_global_max(i));
    
    mode.kt2.set_value(0.01,'override');
    
    mode.kt2.label=r.param_name(i);
    
    mode.kt2.unit=r.param_unit(i);
    
    if isempty(varargin)   
        
        r.c0=c0;
        
        r.r0=r0;
        
        r.rs=rs;
        
        for i=1:length(r.mode)
            
            r.mode(i)=mode;
            
        end
        
    else
         
         if isnumeric(varargin{1})
             
             switch varargin{1}
                 
                 case 1 
                     
                     def_par=c0;
                     
                 case 2
                     
                     def_par=r0;
                     
                 case 3
                     
                     def_par=rs;
                     
                 case 4
                     
                     def_par=mode.fres;
                 case 5
                     
                     def_par=mode.q;
                     
                 case 6
                     
                     def_par=mode.kt2;
                     
             end
             
         end
         
     end
end
