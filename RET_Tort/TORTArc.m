function [x,y,k]=TORTArc(llength,narc,rarc,dbf);

th=0:0.01:pi;

np=fix(length(th)/narc);
x1=rarc*cos(th+pi);
y1=rarc*sin(th);

xr=x1;
yr=y1;
x=[];
y=[];
k=[];
d1=1;
d2=0;
ctp=0;
ctp=np+1;
mul=1;
for ct=1:narc,
    if(ct>1),
        th1=mod(atan2(y(end)-y(end-1),x(end)-x(end-1)),2*pi);
        th2=mod(atan2(yr(2)-yr(1),xr(2)-xr(1)),2*pi);
        dth=th2-th1;
        xt1=xr*cos(dth)+yr*sin(dth);       
        yt1=-xr*sin(dth)+yr*cos(dth);
        xr=xt1-xt1(1)+x(end);
        yr=yt1-yt1(1)+y(end);
        d1=(x(end)-xr(end))^2+(y(end)-yr(end))^2;
        d2=(x(end)-xr(1))^2+(y(end)-yr(1))^2;
    end;
    
    if(d1>d2)
        x=[x,xr(1:np)];
        y=[y,yr(1:np)];
    else
        x=[x,fliplr(xr(1:np))];
        y=[y,fliplr(yr(1:np))];
    end;
        
    k=[k,mul/rarc*ones(1,np)];
    mul=-mul;
    
    if(ctp<=length(xr))
        xt=xr(ctp:end);
        yt=yr(ctp:end);
        dth=pi;
        xr=(xt*cos(dth)+yt*sin(dth));
        yr=max(y)-(-xt*sin(dth)+yt*cos(dth));    
    end;
end;

dth=atan2(y(end)-y(1),x(end)-x(1));
xt=x*cos(dth)+y*sin(dth);       
yt=-x*sin(dth)+y*cos(dth);
x=xt-xt(1);
y=yt-yt(1);