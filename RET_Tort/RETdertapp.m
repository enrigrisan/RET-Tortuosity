%	----------------------
%  - Function RETdertapp -
%	----------------------
%
%
% It gives on the output the PP form that is the first derivative 
% of the input PP form
%
% Sintax:
%
%	(pp)'= RETdertapp(pp,dbf)
%

function ppderta = RETdertapp(f,dbf)

if dbf, disp('Inside RETdertapp'); end;
    
dorder=1;
[breaks,coefs,l,k,d]=ppbrk(f);
ppderta = fnderp(f,dorder);

if dbf, disp('Finished RETdertapp'); end;

%FNDERP Differentiate a univariate function in ppform.
function fprime = fnderp(f,dorder)
[breaks,coefs,l,k,d]=ppbrk(f);
if ( k<=dorder ),
    fprime = ppmak([breaks(1) breaks(l+1)],zeros(d,1));
else
    knew=k-dorder;
    for j=k-1:-1:knew,
        coefs=coefs.*(ones(d*l,1)*[j:-1:j-k+1]);
    end;
    fprime=ppmak(breaks,coefs(:,1:knew),d);
end;

