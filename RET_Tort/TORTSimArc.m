function tindexes=TORTSimArc(rarc,maxarc,tortpar,smoothxy,legenda,dbf);

%rarc=4;
llength=pi*rarc;
%maxarc=6;
%dbf=0;

passo=tortpar.passo;
lmin=tortpar.lmin;
h=tortpar.h;
k0=tortpar.k0;

np1=ceil(sqrt(maxarc));
if(np1*(np1-1)>=maxarc),
    np2=np1-1;
else
    np2=np1;
end;

figure
for na=1:maxarc,
    [x,y,k]=TORTArc(llength,na,rarc,dbf);

    [tindexes(na,:),indici]=TORTind(x,y,k,lmin,h,k0,passo,dbf);
    
%     [s,chord,tc,tsc,ad,nc]=TORTothersArc(x,y,k,dbf);
%     s=pi*rarc;
%     chord=x(end)-x(1);
%     tc=s/rarc;
%     tsc=s/rarc^2;
%     [xz,yz,indici,k]=TORTtrunk2(x,y,k,lmin,h,passo,dbf);
%     
%     n=length(xz);
%     if(n>2)
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
%         li=1;
%     end;
%     % valore di tortuosita' del segmento
%     T=(n-2)/sum(li)*sum(term0);
%     %T=(n-2)/n*sum(term0);
%     %[T,xt,yt,indici]=TORTsegind(ppx,ppy,tortpar,dbf);
    
    subplot(np1,np2,na);    
    h1=plot(x,y);
    axis([min(x),max(x),min(y)-0.1,max(y)+0.1])
    hold on;
    h2=plot(x(indici),y(indici),'or');
    set(gca,'FontSize',12)
    set(h1,'LineWidth',2);
    set(h2,'LineWidth',2);
    
%     %T=segs(ctf).t;
%     tind=TORTindex(s,chord,tc,tsc,T,dbf);
%     bullitt=n*(s/chord);
%     patasius = sum(diff(k).^2)/s;
%     tindexes(na,:)=[tind, ad,nc,bullitt, patasius];
end;


figure;
for ct=1:12,
    subplot(4,3,ct);
    h1=plot([1:maxarc],tindexes(:,ct));
    ylabel(legenda{ct});
    xlabel('Number of arcs');
    nn=find(tindexes(:,ct)~=NaN);
    if(min(tindexes(nn,ct))==max(tindexes(nn,ct))),
        minp=min(tindexes(nn,ct))-0.01;
        maxp=min(tindexes(nn,ct))+0.01;
    else
        minp=min(tindexes(nn,ct));
        maxp=max(tindexes(nn,ct));
    end;        
    axis([1,maxarc,minp,maxp])
    set(gca,'FontSize',12)
    set(h1,'LineWidth',2);
end;