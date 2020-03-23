function y = normalize(p)
            y=0.5;
            if p.value<p.min || p.value>p.max
                fprintf('\nValue is Out of Bound.\n');
                keyboard();
            else
            y   =   p.value ./ (p.max-p.min) - p.min ./ (p.max-p.min) ;
            end
end
