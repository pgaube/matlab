function fz = dfdz(f,dz)
% function fz = dfdz(f,dz)
%Uses centered differance
%Standard output is in units per units of dz
% dz = step in depth, f must be monotonicaly increasing/decreasing

fz = squeeze(finitediff(f,dz));


