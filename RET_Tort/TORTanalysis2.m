

for ct=1:30,
    fname=fn{ct};
    n=findstr(fname,'-');
    fstr{ct}=fname(n:end-5);
end;

[fsort,namesort]=sort(fstr);
clinsort=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30,];
t=[];
for ct=1:length(fsort),
    t(ct,:)=segs(namesort(ct)).t;
end;

for ct=1:size(t,2)
    temp=t(:,ct);
    [tempsort,tortidx]=sort(temp);
    cmat=corrcoef(sort(clinsort),clinsort(tortidx));
    c(ct)=cmat(1,2);
end;
    