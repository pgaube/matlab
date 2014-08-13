function [zi] = grid_2_deg(z);
%function [zi] = grid_2_deg(z);
%
% Inputs
% 
% z = the data used to make the estimate zi [m,n].  Asumes 1/4 degree grid

%
% Output
% zi = z within a 2 degree box

[m,n]=size(z);

cen_x=((m-1)/2)+1;
cen_y=((m-1)/2)+1;

r=cen_x-8:cen_x+8;
c=r;

zz = z(r,c);


x=linspace(-2,2,length(r));
x=ones(length(x),1)*x;
y=x';

xi=[-2:.125:2];
xi=ones(length(xi),1)*xi;
yi=xi';

zi = griddata(x,y,zz,xi,yi,'linear');
