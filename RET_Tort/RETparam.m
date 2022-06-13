%	----------------------
%	- Function RETparam -
%	----------------------
%
% Given as input the vector of abscissa x and the ordinates y of the barycenters	
% of a segment, it computes the curvilinear abscissa of the segment 
%
% Sintax:
%
%	Vector  = RETparam(Vector x,Vector y,flag debug)

function s=RETparam(x,y,dbg);

if dbg, disp('>> Inside RETparam'); end;

sx = length(x);

s(1,1) = 0;
for ct=2:sx,   
   distanza = sqrt((x(ct)-x(ct-1))^2+(y(ct)-y(ct-1))^2);
   s(ct,1)=s(ct-1,1)+distanza;
end;

if dbg
   disp(['-num.  output vector elements  :',num2str(length(s))]);
end;

if dbg, disp('>> Finished RETparam'); end;




