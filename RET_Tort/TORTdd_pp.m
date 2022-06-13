function y = TORTdd_pp(ppx,ppy,passo,dbg)
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


sqppxdd=fncmb(ppxdd,'*',ppxdd);
sqppydd=fncmb(ppydd,'*',ppydd);

ppcurvnum = fncmb(sqppydd,'+',sqppxdd);


ynum=fnval(ppcurvnum,[ppcurvnum.breaks(1):passo:ppcurvnum.breaks(length(ppcurvnum.breaks))]);
y=sqrt(ynum);

% INFO DI DEBUG
if (dbg)
   disp(['		* elements in vector of laplacian =',num2str(length(y))]);
   disp(['		* end  RETk_pp   *']);
end;

