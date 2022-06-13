function [sx,sy,r,c]=RETInteractiveSamples(x,dbf);

[r,c]=getpoints(x);
sx=[];
sy=[];
for ct=2:length(r),
    l=sqrt((c(ct)-c(ct-1))^2+(r(ct)-r(ct-1))^2);
    dv=[c(ct)-c(ct-1),r(ct)-r(ct-1)]/l;
    step=l/10;
    for ct2=1:10
        nx(ct2)=c(ct-1)+ct2*step*dv(1);
        ny(ct2)=r(ct-1)+ct2*step*dv(2);
    end;
    sx=fix([sx,nx]);
    sy=fix([sy,ny]);
end;
    