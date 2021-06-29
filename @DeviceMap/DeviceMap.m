classdef DeviceMap < handle 
   
   properties (SetAccess=protected)
 
        chip_label string ="";
       
        wafer_label string ="";
        
   end
   
   properties (Access=protected)
       
       layout_table table ;
        
       fit_table table; 
       
       delimiters= ["x","_","X"];
       
   end
   
   methods 
       
       function obj=DeviceMap(l1,l2)
           
           % first string is 'wafer_label'
           % second string is 'chip_label'
           
           obj.wafer_label=l1;
           
           obj.chip_label=l2;
           
       end
       
       function set_layout_table(obj,path) 
           % reads a .xlsx table with layout parameters on column
           % first column needs to be a labeling string, es "00x11"
           
           obj.layout_table=obj.read_table(path);
           
       end
       
       function set_fit_table(obj,path) 
           % reads a .xlsx table with fit parameters on column
           % first column needs to be a labeling string, es "00x11"
           
           obj.fit_table=obj.read_table(path);
           
       end
       
       elem=get_device(obj,varargin);
      
       view_table(obj);
       
       mat=get_map(obj);
       
       fig=plot_param(obj,Zpar,varargin);
       
       function test(obj)
           
          disp(obj.str2index('01x03.d2p'));
          
          disp(obj.get_map_dims);
          obj.get_sweep_param(1,'IDTN');
          
       end
       
       pars=get_sweep_param(obj,axis,label);
          
   end
   
   methods (Access=protected)
       
       cell=str2index(obj,tag);
       
       dims=get_map_dims(obj);
       
       dims=get_map_size(obj);

       tab=read_table(obj,path);
       
       x=get_spurious_fom(obj,tab);
          
   end
   
   methods (Static,Access=protected)
       label=filter_sweep_param(axis,layout_param,meas_index);
   end
   
end