function mot_branches=calculate_all_mot(resonator)

%default init
mot_branches=resonator.calculate_mot_branch(1);
mot_branches([1:length(resonator.mode)])=mot_branches;

for i=1:length(resonator.mode)
    mot_branches(i)=resonator.calculate_mot_branch(i);
end

end
