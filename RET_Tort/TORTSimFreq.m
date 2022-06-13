function tindexes=TORTSimFreq(A,fstart,fend,fspace,tstart,tend,tortpar,smoothxy,legenda,dbf);

f=fstart;
x=tstart:0.01:tend;
ctseg=1;
f=fstart:fspace:fend;

passo=tortpar.passo;
lmin=tortpar.lmin;
h=tortpar.h;
k0=tortpar.k0;


nf=length(f);
np1=ceil(sqrt(nf));
if(np1*(np1-1)>=nf),
    np2=np1-1;
else
    np2=np1;
end;

figure;
for ctf=1:nf,
    y=A*sin(x*f(ctf));
    
    k=-((f(ctf)^2*A*sin(x*f(ctf))./(1+(f(ctf)*A*cos(x*f(ctf))).^2).^(1.5)));
    
    [s,chord, tc, tsc, ad, nc] = TORTothersArc(x,y,k,dbf);
    [tindexes(ctf,:),indici]=TORTind(x,y,k,lmin,h,k0,passo,dbf);
%     %[s,chord,tc,tsc,ad,nc]=TORTothers(segs(ctf),dbf);
%     
% %     param=RETparam(x,y,dbf);                         %coordinata curvilinea
% %     ppx = csaps(param,x,smoothxy);
% %     ppy = csaps(param,y,smoothxy);
% %     xs=fnval(ppx,[ppx.breaks(1):passo:ppx.breaks(length(ppx.breaks))]);
% %     ys=fnval(ppy,[ppy.breaks(1):passo:ppy.breaks(length(ppy.breaks))]);
% %     [xz,yz,indici,k]=TORTtrunk_sin(A,f(ctf),xs,ys,lmin,h,passo,dbf);
%     
%     [xz,yz,indici,k]=TORTtrunk2(x,y,k,lmin,h,passo,dbf);
%     
%     % calcola il vettore lunghezza delle corde 
%     n=length(xz);
%     l_chord=sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);
%     if(n>1)
%         for i=1:n-1,
%             nx=x(indici(i):indici(i+1));
%             ny=y(indici(i):indici(i+1));
%             %tc(i) = sum(abs(k(indici(i):indici(i+1))));
%             % calcola il vettore delle lunghezze degli spezzoni
%             li(i)=RETl(nx,ny,1,dbf);
%         end;
% 
%         % calcola il vettore di tortuosita' del segmento
%         for i=1:length(li),
%             term0(i)=k0*((li(i)/l_chord(i))-1);
%         end;
%     else
%         term0=0;
%     end;
%     % valore di tortuosita' del segmento
%     %T=((n-2)/n*sum(term0));
%     T=(n-2)/sum(li)*sum(term0);
% 
%     %[T,xt,yt,indici]=TORTsegind(ppx,ppy,tortpar,dbf);
    
    subplot(np1,np2,ctf); 
    h1=plot(x,y);
    hold on;
    h3=plot(x(indici),y(indici),'or');
    axis([tstart,tend,-A,A]);
    set(gca,'FontSize',12)
    set(h1,'LineWidth',2);
    set(h3,'LineWidth',2);
    
%     %T=segs(ctf).t;
%     tind=TORTindex(s,chord,tc,tsc,T,dbf);
%     bullitt=n*(s/chord);
%     patasius = sum(diff(k).^2)/s;
%     tindexes(ctf,:)=[tind, ad,nc,bullitt, patasius];
end;

figure;
for ct=1:12,
    subplot(4,3,ct);
    h1=plot(f,tindexes(:,ct));
    set(h1,'LineWidth',2);
    h2=ylabel(legenda{ct});
    set(h2,'FontSize',14);
    h2=xlabel('Sinusoid Frequency');
    set(h2,'FontSize',14);
    set(gca,'FontSize',14);
    nn=find(tindexes(:,ct)~=NaN);
    if(min(tindexes(nn,ct))==max(tindexes(nn,ct))),
        minp=min(tindexes(nn,ct))-0.01;
        maxp=min(tindexes(nn,ct))+0.01;
    else
        minp=min(tindexes(nn,ct));
        maxp=max(tindexes(nn,ct));
    end;        
    axis([1,max(f),minp,maxp])
    %set(gca,'FontSize',12)
    set(h1,'LineWidth',2);
end;
    