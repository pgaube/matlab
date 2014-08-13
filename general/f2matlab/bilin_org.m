function [bilinResult,x,y,nx,ny,xg,yg,var,maxx,maxy]=bilin(x,y,nx,ny,xg,yg,var,maxx,maxy,varargin);
clear global; clear functions;
global GlobInArgs nargs
GlobInArgs={mfilename,varargin{:}}; nargs=nargin+1;
bilinResult=[];
persistent amiss 
i=[];j=[];
if isempty(amiss), amiss=1.0e+35 ; end;

[xg,nx,x,i]=lllocate(xg,nx,x,i);
[yg,ny,y,j]=lllocate(yg,ny,y,j);

if(i==0 || j==0 || i==nx || j==ny);
bilinResult=amiss;
return;
end;

if(var(i,j)>=amiss || var(i,j+1)>=amiss || var(i+1,j)>=amiss || var(i+1,j+1)>=amiss);
bilinResult=amiss;
return;
end;

rat=(y-yg(j))./(yg(j+1)-yg(j));
ylo=var(i  ,j)+rat.*(var(i  ,j+1)-var(i  ,j));
yhi=var(i+1,j)+rat.*(var(i+1,j+1)-var(i+1,j));
rat=(x-xg(i))./(xg(i+1)-xg(i));
bilinResult=ylo+rat.*(yhi-ylo);

return;
end



function [xx,n,x,j]=lllocate(xx,n,x,j,varargin);
persistent jl jm ju 

if isempty(jl), jl=0; end;
if isempty(jm), jm=0; end;
if isempty(ju), ju=0; end;
jl=0;
ju=n+1;
if(ju-jl>1);
jm=fix((ju+jl)./2);
if((xx(n)>xx(1))==(x>xx(jm)));
jl=jm;
else;
ju=jm;
end;
goto 10;
end;
j=jl;
return;
end




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