

for ct=1:30,
    fname=fn{ct};
    n=findstr(fname,'-');
    fstr{ct}=fname(n+1:end-4);
end;

[fsort,namesort]=sort(fstr);
clinsort_a=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30];
clinsort_v=[10,4,1,19,8,23,22,13,9,17,21,11,12,20,14,7,5,27,26,25,15,3,24,16,18,28,29,2,6,30];
clinsort=clinsort_v;

t=[];
for ct=1:length(fsort),
    %t(ct,:)=segs(namesort(ct)).t;
    %t(ct,1) = TORTsegind(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    %tpat=TORTpatasius(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    %tbull=TORTbullit(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    [tort,x,y,k,indici]=TORTsegind(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    [t(ct,:),indici]=TORTind(x,y,k,tortpar.lmin,tortpar.h,tortpar.k0,tortpar.passo,dbf);
    %t(ct,end)=tbull;
    %t(ct,end)=tpat;
end;

tsort=zeros(size(t));

for ct=1:size(t,2)
    temp=t(:,ct);
    [tempsort,tortidx]=sort(temp);
    
    %cmat=corrcoef(sort(clinsort),clinsort(tortidx));
    %c(ct)=cmat(1,2);
    c(ct)=corr(sort(clinsort)',clinsort(tortidx)','type','Spearman');
    %tsort(ct,:)=clinsort(tortidx);
end;
    