%Calculates the meridional gradient of the coriolis parameter (f)
function [val] = b(lat);

omega=2*pi/86400;

val = (2*omega*cosd(lat))./6378.1e3;
