for ctdata=1:3,
    load(sprintf('VeinData%i.mat',ctdata));
    if(ctdata~=1)
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
    clinsort=[10,4,1,19,8,23,22,13,9,17,21,11,12,20,14,7,5,27,26,25,15,3,24,16,18,28,29,2,6,30];
    tortpar.h=0.03;                    % hysteresis threshold: arterie=0.03
    tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
    tortpar.lmin=1;

    t=[];
    h=0.001:0.001:0.1;
    for cth=1:length(h)
        
        tortpar.h=h(cth);
        for ctseg=1:length(fsort),
            t(ctseg)=TORTsegind(segs(namesort(ctseg)).ppx,segs(namesort(ctseg)).ppy,tortpar,dbf);
        end;
        [tempsort,tortidx]=sort(t);
        cmat=corrcoef(sort(clinsort),clinsort(tortidx));
        c(ctdata,cth)=cmat(1,2);
        disp(sprintf('Set %i, seg %i, c=%f',ctdata,cth,cmat(1,2)));
    end;
end;