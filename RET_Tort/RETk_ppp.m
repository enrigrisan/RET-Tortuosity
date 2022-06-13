function y = RETk_pp(ppx,ppy,passo,dbg)
%	---------------------------------------
%	- Function RETk_pp - 
%	---------------------------------------
%
% Compute the value of the laplacian for every barycenter
%
% Sintax:
%
%	y = RETk_pp(ppx,ppy,passo,flag debug)
%


% INFO DI DEBUG
if (dbg ) 
   disp(['_']);
   disp(['Call RETk_pp']);
end;

ppxd=RETdertapp(ppx,dbg);
ppyd=RETdertapp(ppy,dbg);
ppxdd  = RETdertapp( RETdertapp(ppx,dbg) , dbg);
ppydd  = RETdertapp( RETdertapp(ppy,dbg) , dbg);


qppxddyd=fncmb(ppxdd,'*',ppyd);
qppyddxd=fncmb(ppydd,'*',ppxd);
qppxd = fncmb(ppxd,'*',ppxd);
qppyd = fncmb(ppyd,'*',ppyd);

ppcurvnum = fncmb(qppyddxd,'-',qppxddyd);
ppcurvden = fncmb(qppxd,'+',qppyd);

%dernum=RETdertapp(ppcurvnum,dbg);
%derden=RETdertapp(ppcurvden,dbg);
%num1= fncmb(dernum,'*',ppcurvden);
%num2= fncmb(derden,'*',ppcurvnum);
%num=fncmb(num1,'-',num2);

yden=(fnval(ppcurvden,[ppcurvden.breaks(1):passo:ppcurvden.breaks(length(ppcurvden.breaks))])).^(3/2);
ynum=fnval(ppcurvnum,[ppcurvnum.breaks(1):passo:ppcurvnum.breaks(length(ppcurvnum.breaks))]);

y=ynum./yden;

% INFO DI DEBUG
if (dbg)
   disp(['		* elements in vector of laplacian =',num2str(length(y))]);
   disp(['		* end  RETk_pp   *']);
end;

