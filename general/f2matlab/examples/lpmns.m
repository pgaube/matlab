function [m,n,x,pm,pd]=lpmns(m,n,x,pm,pd,varargin);

%**************************************************************
%       ========================================================
%       Purpose: Compute associated Legendre functions Pmn(x)
%                and Pmn'(x) for a given order
%       Input :  x --- Argument of Pmn(x)
%                m --- Order of Pmn(x),  m = 0,1,2,...,n
%                n --- Degree of Pmn(x), n = 0,1,2,...,N
%       Output:  PM(n) --- Pmn(x)
%                PD(n) --- Pmn'(x)
%       ========================================================
% implicit double precision(a-h,o-z) ::;
clear global; clear functions;
global GlobInArgs nargs
GlobInArgs={mfilename,varargin{:}}; nargs=nargin+1;

for  k=0:n;
pm(k+1)=0.0d0;
pd(k+1)=0.0d0;
end;
if(abs(x) == 1.0d0) ;
for  k=0:n;
if(m == 0) ;
pm(k+1)=1.0d0;
pd(k+1)=0.5d0.*k.*(k+1.0);
if(x < 0.0) ;
pm(k+1)=(-1).^k.*pm(k+1);
pd(k+1)=(-1).^(k+1).*pd(k+1);
end;
elseif(m == 1) ;
pd(k+1)=1.0d+300;
elseif(m == 2) ;
pd(k+1)=-0.25d0.*(k+2.0).*(k+1.0).*k.*(k-1.0);
if(x < 0.0)
pd(k+1)=(-1).^(k+1).*pd(k+1); 
end;
end;
end;
return;
end;
x0=abs(1.0d0-x.*x);
pm0=1.0d0;
pmk=pm0;
for  k=1:m;
pmk=(2.0d0.*k-1.0d0).*sqrt(x0).*pm0;
pm0=pmk;
end;
pm1=(2.0d0.*m+1.0d0).*x.*pm0;
pm(m+1)=pmk;
pm(m+1+1)=pm1;
for  k=m+2:n;
pm2=((2.0d0.*k-1.0d0).*x.*pm1-(k+m-1.0d0).*pmk)./(k-m);
pm(k+1)=pm2;
pmk=pm1;
pm1=pm2;
end;
pd(0+1)=((1.0d0-m).*pm(1+1)-x.*pm(0+1))./(x.*x-1.0);
for  k=1:n;
pd(k+1)=(k.*x.*pm(k+1)-(k+m).*pm(k-1+1))./(x.*x-1.0d0);
end;
return;
end %subroutine lpmns




function [argStr,status]=getarg(n,argStr,status)
%replicates getarg in fortran
global GlobInArgs nargs
if n<0 || n>nargs
 argStr=''; status=-1;
else
 argStr=GlobInArgs{n+1};
 status=length(argStr);
end
end