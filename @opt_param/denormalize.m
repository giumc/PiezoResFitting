function y = denormalize(p,x)
            y=p.min+0.5*(p.max-p.min);
            
            if x<0 || x>1
                fprintf('\nValue is not normalized to 1 !\n');
                keyboard();
            else
                
            y   =   p.min + x * (p.max - p.min) ;
            end
        end
