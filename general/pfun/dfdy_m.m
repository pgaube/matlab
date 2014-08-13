function fy = dfdy(f,space)
% function fy = dfdy(f,space)
%Uses centered differance
%Standard output is in units per meter
% space = spacing between grid points (for example 1/4 degree: space=.25)

fy = finitediff(f,space);


