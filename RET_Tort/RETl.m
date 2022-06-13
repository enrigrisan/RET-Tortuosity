%	--------------------------------------------
%	- Function Compute Vessel Length - 
%	--------------------------------------------
%
% It receives as input the (x,y) coordinates of the vessel barycenters,
% and gives on the output the vessel length (in pixels) summing the length of the chords
% linking two subsequent barycenters.
% Coeff is a scaling parameters. If it is present, the function gives on the output both 
% the unscaled pixel length y and the scaled one yum
%
% Sintax :
%
%	lenght = RETl(Vector Abscissa,Vettore Ordinates,flag debug)
%
%	[lungh (pixel), lungh (um) = RETl(Vettore Ascisse,Vettore Ordinate,flag debug,coeff um/pel)
%

function l=RETl(vettore_x,vettore_y,coeff,dbf)

if dbf, disp('>> Inside RETl'); end;

dim_vettore = length(vettore_x);
lunghezza   = 0;
x1 = vettore_x(1:dim_vettore-1);
x2 = vettore_x(2:dim_vettore);
y1 = vettore_y(1:dim_vettore-1);
y2 = vettore_y(2:dim_vettore);
l=sum(sqrt((x2-x1).^2+(y2-y1).^2))*coeff;

if dbf, disp('>> Finished RETl'); end;
