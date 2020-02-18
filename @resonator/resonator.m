classdef resonator < handle
    properties
        anus=0;
    end
    
    methods (Static)
        function getanus()
            fprintf("This is an anus!\n");
            fprintf("Currently there are  %d anuses",anus);
        end
    end
end