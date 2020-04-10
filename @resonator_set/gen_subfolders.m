function folders_out = gen_subfolders (obj,name,folders_in)

    folders_out=folders_in;
    exceptions=[".","..",".git"];

    files=dir(name);
    
    files(arrayfun(@(x) any(strcmp(files(x).name,exceptions)),1:length(files)))=[];

    
    for i=1:length(files)

        if files(i).isdir
            new_folder=string(strcat(files(i).folder,filesep,files(i).name));

            folders_new=obj.gen_subfolders(new_folder,folders_in);
            folders_in=[folders_in,folders_new];
        end

    end
    folders_out=[folders_out,name];
    
end
