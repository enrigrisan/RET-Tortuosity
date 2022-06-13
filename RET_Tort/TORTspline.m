function segout=TORTspline(segin,smoothxy,dbf)

segout=segin;
x=segin.x;
y=segin.y;

dir=atan2(y(2:end)-y(1:end-1),x(2:end)-x(1:end-1));
dir(end+1)=dir(end);

param=RETparam(x,y,dbf);                         %coordinata curvilinea
ppx = csaps(param,x,smoothxy);
ppy = csaps(param,y,smoothxy);

segout.dir=dir;
segout.ppx=ppx;
segout.ppy=ppy;
