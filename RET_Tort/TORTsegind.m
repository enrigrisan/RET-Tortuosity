%	---------------------------
%	- Function RETtort_seg   -
%	---------------------------
%
% Computes the tortuosity measure for the input segment described by the
% PP forms ppx ppy ppd
%
% k0   = scale factor
% lmin = minimum distance between two breaking points
%  h   = hysteresis threshold
% passo= resampling step ( the smaller the better)
%
%
% Sintax:
%
%	y = RETtort_seg(ppx, ppy, ppd, k0, lmin, hysteresis thereshold,flag debug)
%

function [tort,x,y,k,indici] = TORTsegind(ppx,ppy,tortpar,dbf)

if dbf, disp('Inside TORTsegind'); end;

k0=tortpar.k0;
lmin=tortpar.lmin;
h=tortpar.h;
passo=tortpar.passo;

x=fnval(ppx,[ppx.breaks(1):passo:ppx.breaks(length(ppx.breaks))]);
y=fnval(ppy,[ppy.breaks(1):passo:ppy.breaks(length(ppy.breaks))]);

[xz,yz,indici]=TORTtrunk_pp_old(ppx,ppy,x,y,lmin,h,passo,dbf);
k = TORTk_pp(ppx,ppy,passo,dbf);

% calcola il vettore lunghezza delle corde 
n=length(xz);
l_chord=sqrt((xz(2:n)-xz(1:n-1)).^2+(yz(2:n)-yz(1:n-1)).^2);

% figure;
% subplot(2,1,1)
% plot(x,y);
% hold on;
% plot(x(indici),y(indici),'or')
% subplot(2,1,2)
% plot(x,k);
% hold on;
% plot([x(1),x(end)],h*ones(1,2),'r');
% plot([x(1),x(end)],-h*ones(1,2),'r');
% plot([x(1),x(end)],zeros(1,2),'r');
% plot(x(indici),k(indici),'or')

if(n>1)
    for i=1:n-1,
        nx=x(indici(i):indici(i+1));
        ny=y(indici(i):indici(i+1));
        tc(i) = sum(abs(k(indici(i):indici(i+1))));
        % calcola il vettore delle lunghezze degli spezzoni
        li(i)=RETl(nx,ny,1,dbf);
    end;
    
    % calcola il vettore di tortuosita' del segmento  
    for i=1:length(li),
        term0(i)=k0*((li(i)/l_chord(i))-1);
    end;
else
    term0=0;
end;
% valore di tortuosita' del segmento
%tort=(n-2)/sqrt((x(1)-x(end))^2+(y(1)-y(end))^2)*sum(term0);
tort=(n-2)/n*sum(term0);
%tort(2)=sum(tc)/sqrt((x(1)-x(end))^2+(y(1)-y(end))^2)*sum(term0);
% if(st==0)
%     tort=log(0.001);
% else
%     tort=log(st+0.001);
% end

if dbf, disp('Finished RETtort_seg'); end;
