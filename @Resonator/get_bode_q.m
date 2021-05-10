function q=get_bode_q(obj,varargin)
    
    if isempty(obj.y_meas)

        error("uninitialized resonator");

    end

    y_meas=obj.y_meas;
    freq=obj.sparam.Frequencies;

    z0=obj.sparam.Impedance;

    z_meas=1./y_meas;

    s_meas=(z_meas-z0)./(z_meas+z0);

    w=2*pi*freq;
    
    group_delay=gradient(phase(s_meas))/gradient(w);
    
    bode_q_w=w.*group_delay*abs(s_meas)./(1-(abs(s_meas)).^2);
    
    antenna_q_w=(w.*gradient(imag(z_meas))./gradient(w)-imag(z_meas))./...
            (2*real(z_meas))
    
    q=max(bode_q_w);
    
    pos=check_if_string_is_present(varargin,'check');
    
    if pos
        
        fig=figure();
        
        fig.Name="Bode Q";
        
        ax=axes(fig);
        
        [freq,scale] =  num2str_sci(freq);
        
        freq_label  =   strcat('Frequency',{' ['},scale,{'Hz]'});

        p(1)=semilogy(ax,freq,abs(bode_q_w),'LineWidth',3,'Color','k','DisplayName','Bode Q');
        
        ax.NextPlot='add';
        
        p(2)=semilogy(ax,freq,abs(antenna_q_w),'LineWidth',3,'Color','r','DisplayName','Antenna Q');
        
        ax.XLabel.String=freq_label;
        
        ax.YLabel.String='Q [dB]';
        
        yyaxis right;
        
        ax.YAxis(2).Color=rgb('Blue');
        
        p(3)=semilogy(ax,freq,abs(y_meas),'LineWidth',3,'Color',rgb('Blue'),'DisplayName','Y res');
        
        ax.YAxis(2).Label.String="Y meas [dB]";
        
        l=legend(ax);
        
        l.Visible='on';
        
        l.Location='southeast';

        yyaxis left;
        
        pause
        
        close(fig);
        
    end
    
end
        