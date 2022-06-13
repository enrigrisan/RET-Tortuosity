function [c,dct]=TORTcorr(index);

dt=(diff(index)>0)-(diff(index)<0);
dct(1,:)=dt(1,:);

ref(1)=1;

for ct=2:size(index,1)-1,
    dct(ct,:)=dct(ct-1,:)+dt(ct,:);
    ref(ct)=ref(ct-1)+1;
end;

for ct=1:size(index,2)
    c(ct,:)=corr(dct(:,ct),ref');
end;