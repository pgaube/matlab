function [u,v]=geostro(lon,lat,ssh,space);
%
%
% Function to calculate the geostrophic velocity from altimeter SSH fields.
% Inputs
% lon = [m,1] in degree
% lat = [1,n] in degree
% ssh= must be in meters!  [m,n]
%
% Outputs
% u = Zonal velocity compoent [m,n]
% v = Meridional velocity compoent [m,n]

ff=f_cor(lat);
g = 9.81; %ms^-2


u = (-g./ff).*dfdy(ssh,space);
v = (g./ff).*dfdx(lat,ssh,space);

