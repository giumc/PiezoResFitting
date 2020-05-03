function inspect(rf)

    reject_foldername='Rejected';
    rejected_res=[];
    for i=1:length(rf.resonators)
        rf.resonators(i).setup_gui('minimal');
        selection=questdlg('Keep data?', ...
                    'Inspection', {'Yes','No','Cancel'});
        switch selection
            case 'Yes'

            case 'No'
                rejected_res=[rejected_res, i];
            case 'Cancel'
                return
        end
    end
    
    if ~isempty(rejected_res)
        
        savefolder=strcat(rf.folder,filesep,reject_foldername);
        filelist=dir(rf.folder);
        token=0;

        %make folder if there isn't one already
        %and if there is one, empty it
        for i=1:length(filelist)

            if filelist(i).isdir==true && strcmp({filelist(i).name},reject_foldername)

                token=1;
                delete(strcat(filelist(i).folder),filesep,filelist(i).name,filesep,'*');
                break

            end

        end
        
        if token==0

            mkdir(savefolder);

        end
        
        for i=1:length(rejected_res)
            oldloc=strcat(rf.res_files(rejected_res(i)).folder,...
                filesep,...
                rf.res_files(rejected_res(i)).name);
            newloc=strcat(savefolder,...
                filesep,...
                rf.res_files(rejected_res(i)).name);
            copyfile(oldloc,newloc);
        end
        
        delete(rf.resonators(rejected_res));
        rf.resonators(rejected_res)=[];
        rf.res_files(rejected_res)=[];
        
    end
    
end
