function flag=prompt_touchstone(resonator)

flag=false;

[choice,pathname]=uigetfile('*.*','Select Sparameter file');
    if choice==0

        return;

    else

        addpath(genpath(pathname));
        savepath;
        rehash;

        if contains(choice,'.s1p')||contains(choice,'.s2p')
            flag=true;
            resonator.touchstone_file   =   choice; 
            resonator.touchstone_folder = pathname;
        %     fprintf('S-Param data added\n');
        end

    end
end
