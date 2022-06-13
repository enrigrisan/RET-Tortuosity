%	----------------------------
%	- Function RETtrunk_pp -
%	----------------------------
%
% Computes the points in which the laplacian of the spline described
% through the input PP forms is zero. It gives as output the abscissa and ordinates
% of these events, the calibre at this points, the number of times it has
% happened
%
% Distanza = minimum distance between two breaking points
%
%
% Sintax:
%
%	[xzero,yzero,dzero,num. attrav.] = RETtrunk_pp(ppx,ppy,ppd,
%                                             distanza, h, passo, flag debug)
%

function [xzero,yzero,indici,peaks]=TORTtrunk_pp2(x,y,k,lmin,h,passo,dbf)

if dbf, disp('Inside TORTtrunk_pp'); end;

sx=length(x);

t=RETparam(x,y,dbf);
%k=TORTk_pp(ppx,ppy,passo,dbf);
%k=abs(k);
statevec=zeros(1,length(k));
statevec=(k>h)-(k<-h);
%inserisce il primo baricentro
ct2=1;
indici(ct2)=1;
bonex(ct2)=x(1);
boney(ct2)=y(1);
bonet(ct2)=t(1);

%state for hyst cycle: 0, high, 1, low
state=0;
cindex=1;
pindex=1;
peaks=1;

for ct1=lmin:sx-lmin,

    switch state
        case 0,
            if abs(k(ct1))<h
                state=1;
                cindex=ct1;
            end;
        case 1,
            if abs(k(ct1))>h,
                if(k(pindex)*k(ct1)<=0)
                    if(cindex==lmin)
                        ni=cindex;
                    else
                        ni=fix((cindex+ct1)/2);
                    end;
                  
                    pindex=ct1;
                    
                    l_x=x(indici(ct2):ni);
                    l_y=y(indici(ct2):ni);

                    l=RETl(l_x,l_y,1,dbf);

                    %breaks only if new subsegment is long enough
                    if (l>lmin)% & k(indici(ct2))*k(ct1)<=0)
                        ct2=ct2+1;
                        peaks(ct2)=pindex;
                        indici(ct2)=ni;
                        bonex(ct2)=x(ni);
                        boney(ct2)=y(ni);
                        bonet(ct2)=t(ni);
                    end;
                    state=0;
                end;
            end;
    end;
end;

%last point insertion
ni=sx;
l_x=x(indici(ct2):ni);
l_y=y(indici(ct2):ni);

l=RETl(l_x,l_y,1,dbf);

%breaks only if new subsegment is long enough
if l>lmin
    ct2=ct2+1;
    indici(ct2)=ni;
    bonex(ct2)=x(ni);
    boney(ct2)=y(ni);
    bonet(ct2)=t(ni);
else
    indici(ct2)=ni;
    bonex(ct2)=x(ni);
    boney(ct2)=y(ni);
    bonet(ct2)=t(ni);
end;

xzero=bonex;
yzero=boney;

if dbf
    figure;
    plot(k);
    hold on
    plot([1,length(k)],[h,h],'r');
    plot([1,length(k)],-[h,h],'r');
    plot(statevec,'k-');
end;

if dbf, disp('Finished TORTtrunk_pp'); end;

