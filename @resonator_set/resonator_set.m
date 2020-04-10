classdef resonator_set < resonator_folder
    properties %(Access=private)
        subfolders resonator_folder;
    end
    methods
        function obj=resonator_set()
            
            obj@resonator_folder();
            
            subf=obj.gen_subfolders(obj.folder,'');
%             for i=1:length(subf)
%                 obj.subfolders(i)=resonator_folder('folder',subf(i));
%             end
            keyboard();
        end
        
        folders=gen_subfolders(obj,path,folders_in);
    end
   
end
