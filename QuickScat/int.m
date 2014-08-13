function out = int(in)
%
% INT returns the integer part of a real number. This command is
% meant to mimic the FORTRAN INT function
%

out = in;
iin = find(in>0);
out(iin) = floor(in(iin));
iout = find(in<0);
out(iout) = fix(in(iout));

