function tindexes=TORTSimAmpl(F,Astart,Aend,Aspace,tstart,tend,tortpar,smoothxy,legenda,dbf);

x=tstart:0.1:tend;
ctseg=1;
a=Astart:Aspace:Aend;

passo=tortpar.passo;
lmin=tortpar.lmin;
h=tortpar.h;
k0=tortpar.k0;

na=length(a);
np1=ceil(sqrt(na));
if(np1*(np1-1)>=na),
    np2=np1-1;
else
    np2=np1;
end;

figure;
for ctf=1:na,
    y=a(ctf)*sin(x*F);
    k=-((F^2*a(ctf)*sin(x*F)./(1+(F*a(ctf)*cos(x*F)).^2).^(1.5)));

    [tindexes(ctf,:),indici]=TORTind(x,y,k,lmin,h,k0,passo,dbf);
    [s,chord, tc, tsc, ad, nc] = TORTothersArc(x,y,k,dbf);
    xz=tstart:pi/F:tend;
    xz=[xz,tend];
    yz=a(ctf)*sin(xz*F);
    n=length(xz);
    for ctn=1:n,
        nx=find(x<=xz(ctn));
        indici(ctn)=nx(end);
    end;
    l_chord=sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);
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
    tindexes(ctf,1)=(n-2)/n/(sum(li))*sum(term0);
    %tindexes(ctf,1)=(length(xz)-1)/(length(xz)+1)/(s)*length(xz)*(a(ctf)/pi/F);
    %tindexes(ctf,1)=(length(xz)-1)/(length(xz)+1)/(s)*(length(xz)*(a(ctf)/pi/F));
    subplot(np1,np2,ctf);
    h1=plot(x,y);
    hold on;
    h3=plot(x(indici),y(indici),'or');
    axis([tstart,tend,-Aend,Aend]);
    set(gca,'FontSize',18)
    set(h1,'LineWidth',2);
    set(h3,'LineWidth',2);
end;

figure;
for ct=1:12,
    subplot(4,3,ct);
    h1=plot(a,tindexes(:,ct));
    set(h1,'LineWidth',2);
    h2=ylabel(legenda{ct});
    set(h2,'FontSize',14);
    h2=xlabel('Sinusoid Amplitude');
    set(h2,'FontSize',14);
    set(gca,'FontSize',14);
    nn=find(tindexes(:,ct)>-Inf);
    if(min(tindexes(nn,ct))==max(tindexes(nn,ct))),
        minp=min(tindexes(nn,ct))-0.01;
        maxp=min(tindexes(nn,ct))+0.01;
    else
        minp=min(tindexes(nn,ct));
        maxp=max(tindexes(nn,ct));
    end;
    axis([1,max(a),minp,maxp])
    %set(gca,'FontSize',12);
    %set(gca,'FontSize',12);
    set(h1,'LineWidth',2);
end;