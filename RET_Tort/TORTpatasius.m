function [tort] = TORTpatasius(ppx,ppy,tortpar,dbf)

if dbf, disp('Inside TORTsegind'); end;

k0=tortpar.k0;
lmin=tortpar.lmin;
h=tortpar.h;
passo=tortpar.passo;

x=fnval(ppx,[ppx.breaks(1):passo:ppx.breaks(length(ppx.breaks))]);
y=fnval(ppy,[ppy.breaks(1):passo:ppy.breaks(length(ppy.breaks))]);

k = RETk_pp(ppx,ppy,passo,dbf);
l = RETlpp_seg(ppx,ppy,passo,0);

tort=sum(diff(k).^2)/l;
