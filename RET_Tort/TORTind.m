function [tindexes,indici]=TORTind(x,y,k,lmin,h,k0,passo,dbf)

[s,chord, tc, tsc, ad, nc] = TORTothersArc(x,y,k,dbf);


%[xz,yz,indici,k]=TORTtrunk2(x,y,k,lmin,h,passo,dbf);
%[xz,yz,indici,peaks]=TORTtrunk_pp2(x,y,k,lmin,h,passo,dbf);
[xz,yz,indici]=TORTreg(x,y,k,h,dbf);
% calcola il vettore lunghezza delle corde
n=length(xz);

bullitt=(n-2)*(s/chord);
patasius = sum(diff(k).^2)/s;

l_chord=sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);

if dbf
    figure(1);
    subplot(2,1,1);
    hold off
    plot(x,y);
    hold on;
    plot(x(indici),y(indici),'or');
    plot(x(indici),y(indici),'r');
    %plot(x(peaks),y(peaks),'ok');
    subplot(2,1,2);
    hold off
    plot(x,k);
    hold on
    plot(x([1,length(x)]),[h,h]);
    plot(x([1,length(x)]),[-h,-h]);
    plot(x(indici),k(indici),'or');
    hold on;

    pause;
end;

if(n>1)
    for i=1:n-1,
        nx=x(indici(i):indici(i+1));
        ny=y(indici(i):indici(i+1));
        %tc(i) = sum(abs(k(indici(i):indici(i+1))));
        % calcola il vettore delle lunghezze degli spezzoni
        li(i)=RETl(nx,ny,1,dbf);
        ki(i)=sum(abs(k(indici(i):indici(i+1))));
    end;

    % calcola il vettore di tortuosita' del segmento
    for i=1:length(li),
        if(l_chord(i)>0)
            term0(i)=k0*((li(i)/l_chord(i))-1);
            term1(i)=((ki(i)/l_chord(i)));
        else
            term0=0;
        end;
    end;
else
    term0=0;
    term1=0;
end;
% valore di tortuosita' del segmento
%T=(n-2)*sum(term0);
%T=(n-2)/sum(li)*sum(term0);
%T=(n-2)/n/sum(li)*sum(term0);
T=(n-2)/n/(sum(li))*sum(term0);
%T=segs(ctf).t;
tind=TORTindex(s,chord,tc,tsc,T,0);
%bullitt=n*(s/chord);
bullitt=(n-2)*(s/chord);
patasius = sum(diff(k).^2)/s;
tindexes=[tind, ad,nc,bullitt, patasius];