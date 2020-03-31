function set_boundary(r,opt_param,value,type)

    if ~isnumeric(value) || ~contains(type,{'min','max'})
        fprintf('\n Could not update boundaries.\n');
        return
    end
    
    switch type
        case 'min'
           opt_param.set_min(value);
        case 'max'
            opt_param.set_max(value);
    end

%     
%     switch index
%         case 1
%            if strcmp(type,'min')
%             r.c0.set_min(value);
%             else
%                 if strcmp(type,'max')
%                     r.c0.set_max(value);
%                 end
%             end
%         case 2
%             if strcmp(type,'min')
%             r.r0.set_min(value);
%             else
%                 if strcmp(type,'max')
%                     r.r0.set_max(value);
%                 end
%             end
%         case 3
%            if strcmp(type,'min')
%             r.rs.set_min(value);
%             else
%                 if strcmp(type,'max')
%                     r.rs.set_max(value);
%                 end
%             end
% 
%         otherwise
%             k=mod(index-1,3);
%             n=floor((index-1)/3);
%             switch k
%                 case 0
%                         if strcmp(type,'min')
%                             r.mode(n).fres.set_min(value);
%                         else
%                             if strcmp(type,'max')
%                                 r.mode(n).fres.set_max(value);
%                             end
%                         end
%                 case 1                      
%                     if strcmp(type,'min')
%                             r.mode(n).q.set_min(value);
%                     else
%                         if strcmp(type,'max')
%                             r.mode(n).q.set_max(value);
%                         end
%                     end
%                 case 2
%                     if strcmp(type,'min')
%                             r.mode(n).kt2.set_min(value);
%                     else
%                         if strcmp(type,'max')
%                             r.mode(n).kt2.set_max(value);
%                         end
%                     end
%             end
    end


    

