function minimal_fig_setup(r)
%     keyborard()
    r.figure.OuterPosition=[0 0 0.5 1];
    r.mag_axis.OuterPosition=[0 0.5 1 0.5];
    r.phase_axis.OuterPosition=[0 0 1 0.5];
    drawnow;
%     keyboard()
end
