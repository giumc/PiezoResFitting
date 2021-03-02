function rejected=filter(r,varargin)
    %filter resonators according to various options:
    %max errors: pass 'maxerror',MAXERROR(float)
    %min modes: pass 'minmodes', MINMODES(float)
    %max modes: pass 'maxmodes',MAXMODES(float)
    %max cap: pass 'maxcap',MAXCAP( in farad)
    %output isarray of indexes of resonators to be deleted
    %if no options, returns empty array
    maxerror=[];
    minmodes=[];
    maxmodes=[];
    maxcap=[];
    rejected=[];
    
if isempty(varargin)
    return
else
    for i=1:length(varargin)
        %check input
        switch varargin{i}
            case 'maxerror'
                if ~isempty(varargin{i+1})
                    maxerror=varargin{i+1};
                else
                    return
                end
            case 'minmodes'
                if ~isempty(varargin{i+1})
                    minmodes=varargin{i+1};
                else
                    return
                end
            case 'maxmodes'
                if ~isempty(varargin{i+1})
                    maxmodes=varargin{i+1};
                else
                    return
                end
            case 'maxcap'
                if ~isempty(varargin{i+1})
                    maxcap=varargin{i+1};
                end
        end
    end
    %sweep resonators, test for inputs and update array
    
    for i=1:length(r.resonators)
        res=r.resonators(i);
        if ~isempty(maxerror)
            if res.fiterror>maxerror
                rejected=[rejected,i];
            end
        end
        if ~isempty(minmodes)
            if length(res.mode)<minmodes
                rejected=[rejected,i];
            end
        end
        
        if ~isempty(maxmodes)
            if length(res.mode)>maxmodes
                rejected=[rejected,i];
            end
        end
        
        if ~isempty(maxcap)
            if res.c0.value>maxcap
                rejected=[rejected,i];
            end
        end
       
    end
    
   %remove duplicates
   rejected=unique(rejected);
   
end
