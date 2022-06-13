function k=TORTnumk(x,y,dbf);

h=x(4)-x(3);

dy=(y(3:end)-y(1:end-2))/(2*h);
ddy=(y(5:end)+y(1:end-4)-2*y(3:end-2))/(4*h^2);
ddy=[ddy(1),ddy,dy(end)];

k=abs(ddy./(1+dy.^2).^(1.5));
