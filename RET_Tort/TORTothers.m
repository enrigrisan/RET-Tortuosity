function [s,chord, tc, tsc, ad, nc] = TORTothers(seg_spline,dbf)
% calcola i parametri poi utilizzati per il calcolo dei diversi indici di tortuositą:
% s
% chord
% tc
% tsc
% ad
% a partire dalla struttura seg_spline

passo=.1;

ppx=seg_spline.ppx;
ppy=seg_spline.ppy;

% vectors of the splines coordinates of the barycenters
x=fnval(ppx,[ppx.breaks(1):passo:ppx.breaks(length(ppx.breaks))]);
y=fnval(ppy,[ppy.breaks(1):passo:ppy.breaks(length(ppy.breaks))]);
lnx=length(x);

%total curvature tc e total squared curvature tsc
k = RETk_pp(ppx,ppy,passo,0);    %curvatura punto per punto k = 1 x length(seg)

%calcolo del passo 'curvilineo' dl
Dx=x(2:end)-x(1:end-1);
Dy=y(2:end)-y(1:end-1);
dl=sqrt(Dx.^2+Dy.^2);
dl(end+1)=dl(end);

tc = sum(abs(k).*dl);              %   abs(k)*dl'
tsc = sum(abs(k).^2.*dl);          %   abs(k).^2*dl'

% lunghezza della curva
s = RETlpp_seg(ppx,ppy,passo,0);

% lunghezza della corda 
chord = sqrt((x(lnx)-x(1)).^2+(y(lnx)-y(1)).^2);

%local directional changes: computes the average of the angles between
%sample points describing the vessel
step=fix(2/mean(dl));
Dx=x(1+step:end)-x(1:end-step);
Dy=y(1+step:end)-y(1:end-step);
Dl2=sqrt(Dx.^2+Dy.^2);
alfa=atan2(Dx./Dl2,Dy./Dl2);
Dalfa=abs(alfa(1+step:end)-alfa(1:end-step));
ad=1/(s-step*passo)*sum(Dalfa); %Chandrinos et al

step=fix(20/mean(dl));
Dalfa=(alfa(1+step:end)-alfa(1:end-step));
nch=find(abs(Dalfa(2:end))>pi/6 & abs(Dalfa(1:end-1))<pi/6); %Goh et al et al
if(isempty(nch))
    nc=0;
else
    nc=length(nch);
end;

if dbf==1
    disp(sprintf('s  = %f',s));
    disp(sprintf('chord = %f',chord));
    disp(sprintf('tc = %f',tc));
    disp(sprintf('tsc = %f',tsc));
    disp(sprintf('ad = %f',ad));
end