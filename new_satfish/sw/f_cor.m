%function [f,b] = f(lat);% Calculates the coriolis parameter (f)
% Inputs
% lat = [m,n]
%
% Outputs
% f = coriolis parameter
% b = Beta == df/dy

function [f,b] = f_cor(lat);

omega=2*pi/86400;
re=6371000;

f = 2*omega*sind(lat);


b = (2*omega*cosd(lat))./re;