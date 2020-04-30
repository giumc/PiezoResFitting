function prompt_touchstone(resonator)

[choice,pathname]=uigetfile('*.*','Select Sparameter file');
if choice==0
    return;
end

addpath(genpath(pathname));
savepath;
rehash;

if contains(choice,'.s1p')||contains(choice,'.s2p')
    resonator.touchstone_file   =   choice; 
    resonator.save_folder = pathname;
%     fprintf('S-Param data added\n');
end

end
