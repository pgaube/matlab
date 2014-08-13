function strm = wind2stress(spd)

rho0 = 1.223;   % density
a0   = 2.7e-3;
b0   = 0.142e-3;
c0   = 0.0764e-3;

%
% [ustress,vstress] = WIND2STRESS(u,v)
%
% OR
%
% [ustress,vstress,cn] = WIND2STRESS(u,v)
%
% Given u, v in m/s returns stress in N/m^2
%
% May also return the neutral stability drag coefficient (CN) used to determine
% the wind stress from the wind, which is based on Large and Pond (1982) with 
% a low speed adjustment suggested by Trenberth et al. (1990).
%
% Assumes a surface air density of 1.223 kg/m^3
%
%

%strm = getstress(spd);
%ustr = strm.*cos(dir);
%vstr = strm.*sin(dir);

%spd = sqrt(u.*u+v.*v);
%i1 = (spd > 0);
%if isempty(i1) == 0,
%   ustr(i1) = u(i1)./spd(i1).*strm(i1);
%   vstr(i1) = v(i1)./spd(i1).*strm(i1);
%end

%i1 = (spd == 0);
%ustr(i1) = 0;
%vstr(i1) = 0;

%---------------------------------------------------------------------------

%function stress = getstress(spd)

% Subroutine to use the modified large&pond drag coefficient to calculate
% stress magnitude from wind speed (spd assumed to be 10m)
% density=1.223 kg/m3


spd2 = spd.*spd;
strm = rho0*(a0*spd + b0*spd2 + c0*spd2.*spd);

return



if 0,
sspd=spd;
ro = 12.23;
i1 = find(sspd > 10.);
i2 = find(sspd >= 3. & sspd <= 10.);
i3 = find(sspd >= 1. & sspd < 3.);
i4 = find(sspd < 1.);

cn = repmat(NaN,size(spd));
cn(i1) = (0.49+0.065*sspd(i1))*1.e-3;
cn(i2) = 1.14e-3;
cn(i3) = (0.62+1.56./sspd(i3))*1.e-3;
cn(i4) = 2.18e-3;
stress = ro.*cn.*sspd.*sspd;
end
