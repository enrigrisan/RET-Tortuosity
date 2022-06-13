function tindexes=TORTSimFreqCirc(rarc,nmaxarc,tortpar,legenda,dbf);

na=1:nmaxarc;

passo=tortpar.passo;
lmin=tortpar.lmin;
h=tortpar.h;
k0=tortpar.k0;


np1=ceil(sqrt(nmaxarc));
if(np1*(np1-1)>=nmaxarc),
    np2=np1-1;
else
    np2=np1;
end;

figure;
for ctf=1:nmaxarc,
    narcs=na(ctf);
    [x,y,k,dy,ddy]=TORTCombineArcs(narcs,rarc,0,6);
    
    [tindexes(ctf,:),indici]=TORTind(x,y,k,lmin,h,k0,passo,dbf);
    
%     [s,chord,tc,tsc,ad,nc]=TORTothers2(x,y,k,dy,dbf);
%     
%     [xz,yz,indici,k]=TORTtrunk2(x,y,abs(ddy),lmin,h,passo,dbf);
%     % calcola il vettore lunghezza delle corde 
%     n=length(xz);
%     if(n>1)
%         for i=1:n-1,
%             nx=x(indici(i):indici(i+1));
%             ny=y(indici(i):indici(i+1));
%             %tc(i) = sum(abs(k(indici(i):indici(i+1))));
%             % calcola il vettore delle lunghezze degli spezzoni
%             l_chord(i)=sqrt((xz(i+1)-xz(i))^2+(yz(i+1)-yz(i))^2);
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
%     n=ctf+1;
%     T=(n-2)/sum(li)*sum(term0);
% 
%     %[T,xt,yt,indici]=TORTsegind(ppx,ppy,tortpar,dbf);
%     
     subplot(np1,np2,ctf); 
     plot(x,y);
     hold on;
     plot(x(indici),y(indici),'or');
%     
%     %T=segs(ctf).t;
%     tind=TORTindex(s,chord,tc,tsc,T,dbf);
%     bullitt=n*(s/chord);
%     patasius = sum(diff(k).^2)/s;
%     tindexes(ctf,:)=[tind, ad,nc,bullitt, patasius];
end;

figure;
for ct=1:12,
    subplot(4,3,ct);
    h1=plot(na,tindexes(:,ct));
    set(h1,'LineWidth',2);
    h2=ylabel(legenda{ct});
    set(h2,'FontSize',14);
    h2=xlabel('Number of turns');
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
    axis([1,max(na),minp,maxp])
end;
    