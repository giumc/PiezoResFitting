function fit_all(r,varargin)
%pass option 'printfig' to display resonator fit while fitting
r.progressbar('Fitting Resonators');

printfig=false;

option_opt={'fit_all_modes','fit_routine'};

choiceopt='fit_routine';

if ~isempty(varargin)
    
    for i=1:length(varargin)
        
        if strcmp(varargin{i},'printfig')
            
            printfig=true;
            
        end
        
        if strcmp(varargin{i},option_opt{1})
            
            choiceopt=varargin{i};
            
        end
        
        if strcmp(varargin{i},option_opt{2})
            
            choiceopt=varargin{i};
            
        end
        
    end
    
end

    for i=1:length(r.resonators)
        
        if printfig
            
            r.resonators(i).setup_gui('minimal');
            
        end
        
        r.resonators(i).reset;
        
        if strcmp(choiceopt,option_opt{1})
            
            r.resonators(i).fit_all_modes;
            
        else
            
             if strcmp(choiceopt,option_opt{2})
                 
                r.resonators(i).fit_routine;
                
             end
             
        end
        
        if printfig
            
            r.resonators(i).delete_gui();
            
        end
        
        r.progressbar(i/length(r.resonators));
        
    end
    
end
