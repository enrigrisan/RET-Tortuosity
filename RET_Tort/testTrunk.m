


param=RETparam(x,y,dbf);                         %coordinata curvilinea
ppx = csaps(param,x,smoothxy);
ppy = csaps(param,y,smoothxy);
xs=fnval(ppx,[ppx.breaks(1):tortpar.passo:ppx.breaks(length(ppx.breaks))]);
ys=fnval(ppy,[ppy.breaks(1):tortpar.passo:ppy.breaks(length(ppy.breaks))]);

k=RETk_pp(ppx,ppy,tortpar.passo,dbf);
k=abs(k);

figure;
plot(k);
hold on
plot([1,length(k)],ones(1,2)*tortpar.h);
hi=0;
ho=0;

ct2=1;
indici(ct2)=1;
bonex(ct2)=x(1);
boney(ct2)=y(1);


sx=length(xs);
state=0;
cindex=1;
for ct1=lmin:sx-lmin,   
    switch state
    case 0,
        disp([0,ct1])
        if k(ct1)<h,
            state=1;
            cindex=ct1;
            if(hi)
                delete(hi)
            end;
            hi=plot(cindex,k(cindex),'or');
            pause
        end;
    case 1,
        if k(ct1)>h,
            
            if(cindex==lmin)
                ni=cindex;
            else
                ni=fix((cindex+ct1)/2);
            end;
            
            if(ho)
                delete(ho)
            end;
            ho=plot(ni,k(ni),'ok');
            pause
            l_x=xs(indici(ct2):ni);
            l_y=ys(indici(ct2):ni);
            
            l=RETl(l_x,l_y,1,dbf);
            
            %breaks only if new subsegment is long enough
            if l>lmin
                ct2=ct2+1;
                disp(sprintf('cindex=%i, ni=%i',cindex,ni))
                indici(ct2)=ni;
                bonex(ct2)=xs(ni);
                boney(ct2)=ys(ni);
            end;
            state=0;
        end;
    end;
end;

ni=sx;
l_x=xs(indici(ct2):ni);
l_y=ys(indici(ct2):ni);

l=RETl(l_x,l_y,1,dbf);

%breaks only if new subsegment is long enough
if l>lmin
    ct2=ct2+1;
    indici(ct2)=ni;
    bonex(ct2)=xs(ni);
    boney(ct2)=ys(ni);
else
    indici(ct2)=ni;
    bonex(ct2)=xs(ni);
    boney(ct2)=ys(ni);
end;