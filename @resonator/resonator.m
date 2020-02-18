classdef resonator < handle
    properties
        anus=0;
    end
    
    methods %Constructor
        function obj=resonator()
            setanus(obj);
        end
    end
            
            
    methods
        function getanus(obj)
            fprintf("This is an anus!\n");
            fprintf("Currently there are  %d anuses\n",obj.anus);
            
        end
        function setanus(obj)
            fprintf('How many anuses in a resonator?\n');
            prompt = {'How many anuses for a resonator?'};
            dlgtitle = 'Question';
            dims = 1;
            definput = {'3'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            obj.anus=str2num(answer{1});
        end
    end
end