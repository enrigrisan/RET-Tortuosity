%	--------------------------------------------
%	- Function spline approximation vessel segment length - 
%	--------------------------------------------
%
% Given as input the PP forms for the barycenter coordinates
% it computes the segment length
% 
%
% Sintax :
%
%	l = RETlpp_seg(ppx,ppy,passo,flag debug)
%
%

function y = RETlpp_seg(ppx,ppy,passo,dbf)

if dbf, disp('Inside RETlpp_seg'); end;

ppxd=RETdertapp(ppx,dbf);
ppyd=RETdertapp(ppy,dbf);
qppxd=fncmb(ppxd,'*',ppxd);
qppyd=fncmb(ppyd,'*',ppyd);
arg=fncmb(qppxd,'+',qppyd);

valarg = passo*sum(sqrt(fnval(arg,[arg.breaks(1):passo:arg.breaks(length(arg.breaks))])));

y = valarg;

if dbf, disp('Finished RETlpp_seg'); end;

