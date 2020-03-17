function populate_bars(r)

bars=r.boundaries_bars;

for i=1:r.n_param
        switch i 
            case 1
                v=r.c0;
            case 2
                v=r.r0;
            case 3
                v=r.rs;
            otherwise
                index=mod(i,3);
                n=floor((i-1)/3);
                mode=r.mode(n);
                switch index
                    case 1
                        v=mode.fres;
                    case 2
                        v=mode.q;
                    case 0
                        v=mode.kt2;
                end
        end
        
          bars(i).Value=v;

    end
end
