dbf=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Paramaters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
smoothxy=0.01;
tortpar.k0=10;                     % scale factor
%tortpar.h=0.01;                   % hysteresis threshold: vene=0.01 
%tortpar.h=0.03;                    % hysteresis threshold: arterie=0.03 
tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
tortpar.lmin=1;                    % minimum distance between two breaking points

if(~isempty(findstr(fname,'-'))),
    for ctn=1:30,
        fname=fn{ctn};
        n=findstr(fname,'-');
        fstr{ctn}=fname(n+1:end-4);
    end;
else
    for ctn=1:30,
        fname=fn{ctn};
        n=findstr(fname,'_');
        fstr{ctn}=fname(1:n-1);
    end;
end;

    [fsort,namesort]=sort(fstr);
    clinsort_a=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30,];
    clinsort_v=[10,4,1,19,8,23,22,13,9,17,21,11,12,20,14,7,5,27,26,25,15,3,24,16,18,28,29,2,6,30];
    clinsort=clinsort_a;
    
titlewritten=0;
for ctseg=1:length(fsort),
    fname=fn{namesort(ctseg)};
    [s,chord,tc,tsc,ad,nc]=TORTothers(segs(namesort(ctseg)),dbf);
    
    T=TORTsegind(segs(namesort(ctseg)).ppx,segs(namesort(ctseg)).ppy,tortpar,dbf);
    
    tind=TORTindex(s,chord,tc,tsc,T,dbf);
    tindexes(ctseg,:)=[tind,ad,nc];
    %disp([T,tind(1),tindexes(ctseg,1)]);
    F=fopen(['.','\',savefile],'a+');
    if(titlewritten==0)
        fprintf(F,'Image Name, Tortuosity, s/chord-1, tc, tsc, tc/s, tsc/s, tc/chord, tsc/chord, chandrinos, goh\n');
        titlewritten=1;
    end;
    
    fprintf(F,'%s',fname);
    for ctt=1:size(tindexes,2);
        fprintf(F,',%f',tindexes(ctseg,ctt));
    end;
    fprintf(F,'\n');
    fclose(F);
end;

F=fopen(['.','\',savefile],'a+');
fprintf(F,'Corr');
for ct=1:size(tindexes,2)
    temp=tindexes(:,ct);
    [tempsort,tortidx]=sort(temp);
    cmat=corrcoef(sort(clinsort),clinsort(tortidx));
    c(ct)=cmat(1,2);
    
    fprintf(F,',%f',c(ct));
end;
fprintf(F,'\n');
fclose(F);