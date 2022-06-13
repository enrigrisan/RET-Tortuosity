

for ct=1:30,
    fname=fn{ct};
    n=findstr(fname,'_');
    fstr{ct}=fname(1:n-1);
end;

[fsort,namesort]=sort(fstr);
clinsort_a=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30,];
clinsort_v=[10,4,1,19,8,23,22,13,9,17,21,11,12,20,14,7,5,27,26,25,15,3,24,16,18,28,29,2,6,30];
tortpar.k0=10;                     % scale factor

%tortpar.h=0.01;                   % hysteresis threshold: vene=0.01 
tortpar.h=0.03;                    % hysteresis threshold: arterie=0.03 
tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
tortpar.lmin=1;

t=[];
h=0.001:0.001:0.1;
for cth=1:length(h)
    disp(cth);
    tortpar.h=h(cth);
    for ct=1:length(fsort),
        t(ct)=TORTsegind(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    end;
        [tempsort,tortidx]=sort(t);
        cmat=corrcoef(sort(clinsort),clinsort(tortidx));
        c(cth)=cmat(1,2);
end;
    