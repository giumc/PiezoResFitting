function flag=prompt_touchstone(resonator)

flag=false;

[choice,pathname]=uigetfile('*.*','Select Sparameter file');
    if choice==0

        return;

    else

        addpath(genpath(pathname));
        savepath;
        rehash;

        if contains(choice,{'s1p','s2p','S1P','S2P'})
            
            flag=true;
            resonator.touchstone_file   =   choice; 
            resonator.touchstone_folder = pathname;
        %     fprintf('S-Param data added\n');
        end

    end
end
