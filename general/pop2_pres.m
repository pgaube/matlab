function [PRE] = pop2_pres(DEP);

% convert depth to pressure as in POP2
% input:
%   DEP = depth (m)
% output:
%   PRE = pressure (db)

PRE = 0.59808*(exp(-0.025*DEP)-1.0)+DEP.*(1.00766+DEP*(2.28405e-6));
