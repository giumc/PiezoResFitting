function outcome=read_all(obj)

    formats=obj.format_files;
    
    tbs=[];
    
    outcome=false;
    
    foldeobjiles=dir(obj.folder);
    
    for k=1:length(foldeobjiles)
        
        if contains(string(foldeobjiles(k).name),formats)
            
            tbs=[tbs,k];
            
        end
        
    end
    
    files=foldeobjiles(tbs);
    
   	obj.res_files=files;
    
    obj.progressbar('Initializing Resonators');
    
    if ~isempty(files)
        
        outcome=true;
        
        obj.resonators=Resonator.empty;
        
        for k=1:length(files)
            
            fullpath=strcat(files(k).folder,filesep,files(k).name);
            
            obj.resonators(k)=Resonator('file',fullpath);
            
            obj.resonators(k).tag=files(k).name;
            
            obj.resonators(k).max_modes=obj.max_modes;
            
            obj.progressbar(k/length(files));
            
        end
        
    end
    
end

