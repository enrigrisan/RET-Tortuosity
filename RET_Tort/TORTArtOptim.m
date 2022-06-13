for ctdata=1:3,
    load(sprintf('ArtData%i.mat',ctdata));
    for ctn=1:30,
        fname=fn{ctn};
        n=findstr(fname,'-');
        fstr{ctn}=fname(n+1:end-4);
    end;

    [fsort,namesort]=sort(fstr);
    clinsort=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30,];
    tortpar.h=0.03;                    % hysteresis threshold: arterie=0.03
    tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
    tortpar.lmin=1;

    t=[];
    h=0.001:0.001:0.1;
    for cth=1:length(h)
        disp(sprintf('Set %i, seg %i',ctdata,cth));
        tortpar.h=h(cth);
        for ctseg=1:length(fsort),
            t(ctseg)=TORTsegind(segs(namesort(ctseg)).ppx,segs(namesort(ctseg)).ppy,tortpar,dbf);
        end;
        [tempsort,tortidx]=sort(t);
        cmat=corrcoef(sort(clinsort),clinsort(tortidx));
        c(ctdata,cth)=cmat(1,2);
    end;
end;