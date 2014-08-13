function [RHO] = pop2_state(TEMP, SALT, dep);

% Equation of State used in POP2
% input:
%   TEMP = potential temperature (C)
%   SALT = salinity (psu)
%   dep = reference depth (m)
% output:
%   RHO = potential density (kg/m3) referenced to dep
% requires:
%   pop2_pres.m

TQ = max(TEMP,-2);
SQ = max(SALT,0);         
SQR = sqrt(SQ);
p = pop2_pres(dep);

% first calculate numerator

n0t0 = 999.843699 + p*((1.04004591e-2)-(3.24041825e-8)*p);
n0t1 = 7.35212840;
n0t2 = (-5.45928211e-2)+p*((1.03970529e-7)-(1.23869360e-11)*p);
n0t3 = 3.98476704e-4;
n1t0 = 2.96938239 + p*(5.18761880e-6);
n1t1 = -7.23268813e-3;
n2t0 = 2.12382341e-3;

WORK1 = n0t0 + TQ.*(n0t1 + TQ.*(n0t2 + n0t3*TQ)) + ... 
               SQ.*(n1t0 + n1t1*TQ + n2t0*SQ);

% now calculate denominator 

d0t0 = 1.0 + (5.30848875e-6)* p;
d0t1 = (7.28606739e-3) - (1.27934137e-17)* p*p*p;
d0t2 = -4.60835542e-5;
d0t3 = (3.68390573e-7) - (3.03175128e-16)* p*p;
d0t4 = 1.80809186e-10;
d1t0 = 2.14691708e-3;
d1t1 = -9.27062484e-6;
d1t3 = -1.78343643e-10;
dqt0 = 4.76534122e-6;
dqt2 = 1.63410736e-9;

WORK2 = d0t0 + TQ.*(d0t1 + TQ.*(d0t2 + TQ.*(d0t3 + d0t4*TQ))) + ... 
               SQ.*(d1t0 + TQ.*(d1t1 + TQ.*TQ.*d1t3) + ... 
                    SQR.*(dqt0 + TQ.*TQ.*dqt2) );

RHO  = WORK1./WORK2;
