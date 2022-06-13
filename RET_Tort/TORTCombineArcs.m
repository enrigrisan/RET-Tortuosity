function [x,y,k,dy,ddy]=TORTCombineArcs(narcs,rarc,tstart,tend),



tstart=0;
tend=narcs*2*rarc;
range=tend-tstart;
dspace=((range-(2*rarc*narcs))/(2*narcs));

if(narcs*2*rarc>tend-tstart)
    error('Not possible to fit the n arcs in the given x-span', '%s', 'Not possible to fit the n arcs in the given x-span');
end;

thstart=acos(rarc/(dspace+rarc));
thend=pi-thstart;
xspace=max(0.001,0.001*min(rarc+dspace-rarc*cos(thstart),2*rarc*abs(cos(thend))));
xspacearc=rarc*cos(thend):xspace:rarc*cos(thstart);
yspacearc=rarc*sin(acos(xspacearc/rarc));
dyarc=xspacearc;
xc=rarc+dspace;

dy=0;
ddy=0;
yc=0;
x=0;
y=0;
k=0;
mul=1;
n=1;
while(n<=narcs),
    %%Straight connection up
    if(dspace>0)
        x1=xc-rarc-dspace;
        x2=xc-rarc*cos(thstart);
        %xcon=x1:(x2-x1)*0.01:x2;
        xcon=x1:xspace:x2;
        ycon=(xcon-xcon(1))/(tan(thstart));
        kcon=zeros(1,length(xcon));
        dycon=ones(1,length(xcon))/tan(thstart);
        ddycon=zeros(1,length(xcon));
        
        x=[x,xcon];
        y=[y,mul*ycon];
        k=[k,kcon];
        dy=[dy,mul*dycon];
        ddy=[ddy,mul*ddycon];
    end;

    %% Arc
    th=thstart:(thend-thstart)*0.01:thend;
    %xarc=xc+rarc*cos(th+pi);
    %yarc=yc+rarc*sin(th);
    xarc=xc+xspacearc;
    yarc=yc+yspacearc;
    karc=ones(1,length(xarc))/rarc;
    
    x=[x,xarc];
    y=[y,mul*yarc];
    k=[k,mul*karc];
    dy=[dy,dyarc];
    ddy=[ddy,-mul*yarc];

    %%Straight connection down
    if(dspace>0)
        x1=x(end);
        y1=y(end);
        x2=xc+rarc+dspace;
        y2=0;
        %xcon=x1:(x2-x1)*0.01:x2;
        xcon=x1:xspace:x2;
        ycon=-(xcon-x2)/(tan(thstart));
        kcon=zeros(1,length(xcon));
        dycon=-ones(1,length(xcon))/tan(thstart);
        ddycon=zeros(1,length(xcon));
        
        x=[x,xcon];
        y=[y,mul*ycon];
        k=[k,kcon];
        dy=[dy,mul*dycon];
        ddy=[ddy,mul*ddycon];    
    end;
    
    %%Arc center update
    xc=xc+2*dspace+2*rarc;
    yc=0;
    mul=-mul;
    n=n+1;
end;

