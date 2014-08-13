function yp = lotka(t,y)
%LOTKA  Lotka-Volterra predator-prey model.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.7 $  $Date: 2002/04/15 03:33:21 $
global m
global b
global mu
global g

yp = diag([mu - g*y(2), -m + b*y(1)])*y;
