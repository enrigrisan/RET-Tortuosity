function imt=TORTSimAmplFreq(imf,ima,tstart,tend,tortpar,smoothxy,legenda,dbf);

passo=tortpar.passo;
lmin=tortpar.lmin;
h=tortpar.h;
k0=tortpar.k0;

x=tstart:0.01:tend;
ctseg=1;
for ctf=1:size(imf,1),
    for cta=1:size(imf,2)
        f=imf(ctf,cta);
        a=ima(ctf,cta);
        y=a*sin(x*f);
        k=-((f^2*a*sin(x*f))./(1+(f*a*cos(x*f)).^2).^(1.5));

        [s,chord, tc, tsc, ad, nc] = TORTothersArc(x,y,k,dbf);

        [xz,yz,indici,k]=TORTtrunk2(x,y,k,lmin,h,passo,dbf);
        % calcola il vettore lunghezza delle corde
        n=length(xz);
        %l_chord=sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);
        if(n>1)
            for i=1:n-1,
                nx=x(indici(i):indici(i+1));
                ny=y(indici(i):indici(i+1));
                %tc(i) = sum(abs(k(indici(i):indici(i+1))));
                % calcola il vettore delle lunghezze degli spezzoni
                l_chord(i)=sqrt((xz(i+1)-xz(i))^2+(yz(i+1)-yz(i))^2);
                li(i)=RETl(nx,ny,1,dbf);
            end;

            % calcola il vettore di tortuosita' del segmento
            %disp([length(li),length(l_chord)])
            term0=k0*((li./l_chord)-1);
        else
            term0=0;
        end;
        % valore di tortuosita' del segmento
        T=(n-2)/sum(li)*sum(term0);

        tind=TORTindex(s,chord,tc,tsc,T,dbf);
        imt(ctf,cta,:)=[tind,ad,nc];
    end;
end;
