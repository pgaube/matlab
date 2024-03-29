function [xi,eta,phi,m,n,lambda,h0,an,am,pt,crea_par]=h1f(xi,eta,phi,m,n,lambda,h0,an,am,pt,crea_par,varargin);


clear global; clear functions;
global GlobInArgs nargs
GlobInArgs={mfilename,varargin{:}}; nargs=nargin+1;
persistent h1 t1 t10 t100 t103 t108 t11 t112 t12 t13 t15 t16 t166 t17 t2 t21 t22 t23 t25 t28 t3 t30 t32 t35 t39 t4 t44 t45 t46 t5 t52 t56 t57 t62 t68 t7 t71 t78 t79 t8 t83 t94 t95 t99 

if isempty(h1), h1=zeros(1,3); end;
if isempty(t1), t1=0; end;
if isempty(t10), t10=0; end;
if isempty(t100), t100=0; end;
if isempty(t103), t103=0; end;
if isempty(t108), t108=0; end;
if isempty(t11), t11=0; end;
if isempty(t112), t112=0; end;
if isempty(t12), t12=0; end;
if isempty(t13), t13=0; end;
if isempty(t15), t15=0; end;
if isempty(t16), t16=0; end;
if isempty(t166), t166=0; end;
if isempty(t17), t17=0; end;
if isempty(t2), t2=0; end;
if isempty(t21), t21=0; end;
if isempty(t22), t22=0; end;
if isempty(t23), t23=0; end;
if isempty(t25), t25=0; end;
if isempty(t28), t28=0; end;
if isempty(t3), t3=0; end;
if isempty(t30), t30=0; end;
if isempty(t32), t32=0; end;
if isempty(t35), t35=0; end;
if isempty(t39), t39=0; end;
if isempty(t4), t4=0; end;
if isempty(t44), t44=0; end;
if isempty(t45), t45=0; end;
if isempty(t46), t46=0; end;
if isempty(t5), t5=0; end;
if isempty(t52), t52=0; end;
if isempty(t56), t56=0; end;
if isempty(t57), t57=0; end;
if isempty(t62), t62=0; end;
if isempty(t68), t68=0; end;
if isempty(t7), t7=0; end;
if isempty(t71), t71=0; end;
if isempty(t78), t78=0; end;
if isempty(t79), t79=0; end;
if isempty(t8), t8=0; end;
if isempty(t83), t83=0; end;
if isempty(t94), t94=0; end;
if isempty(t95), t95=0; end;
if isempty(t99), t99=0; end;
t1 = xi.^2;
t2 = eta.^2;
t3 = t1-t2;
t4 = sqrt(t3);
t5 = 1./t4;
t7 = s(eta);
t8 = r(xi);
t10 = am.*t5.*t7.*t8;
t11 =(-1).^pt;
t12 = t11.*m;
t13 = t(phi);
t15 = -1+t1;
t16 = sqrt(t15);
t17 = 1./t16;
t21 = 1./c;
t22 = t21.*t16;
t23 = 1-t2;
t25 = 1./t3;
t28 = c.^2;
t30 = t2.^2;
t32 = m.^2;
t35 =(eta-1).^2;
t39 =(eta+1).^2;
t44 = 1./t23;
t45 = 1./t15;
t46 = t44.*t45;
t52 = t23.*t25;
t56 = t3.^2;
t57 = 1./t56;
t62 = diff(r(xi),xi);
t68 = eta.*t25;
t71 = -t23;
t78 = diff(s(eta),eta);
t79 = t78.*t8;
t83 = 1./t4./t3;
h1(1) =(-t10.*t12.*t13.*eta.*t17+((-t22.*t5.*(xi.*t23.*t25.*(-lambda+lambda.*t2+t28.*t2-t28.*t30+t32)./t35./t39-t32.*xi.*t46).*t8+t22.*t5.*(t52-2.*t2.*t25+2.*t2.*t23.*t57).*t62).*t7-t22.*t5.*xi.*(-2.*t68+2.*t23.*t57.*eta-2.*t52.*eta./t71).*t79+t22.*t83.*eta.*t23.*t78.*t62).*t13.*an).*h0;
t94 = sqrt(t23);
t95 = 1./t94;
t99 = t21.*t94;
t100 = eta.*t15;
t103 = t1.^2;
t108 =(xi-1).^2;
t112 =(xi+1).^2;
h1(2) =(t10.*t12.*t13.*xi.*t95+((t99.*t5.*(-t100.*t25.*(lambda.*t1-lambda-t28.*t103+t28.*t1+t32)./t108./t112+t32.*eta.*t46).*t8+2.*t99./t4./t56.*t100.*t62.*xi).*t7+t99.*t5.*t78.*(t15.*t25+2.*t1.*t25-2.*t1.*t15.*t57).*t8+t99.*t83.*t78.*xi.*t15.*t62).*t13.*an).*h0;
t166 = t21.*m;
h1(3) =((t71.*t62.*eta.*t16.*t25.*t95.*t7-t71.*t78.*t8.*xi.*t16.*t25.*t95).*t13.*am+((t166.*t94.*t16.*t25.*(-t45-t44).*t11.*t8-t166.*t95.*t16.*t25.*xi.*t62.*t11).*t7-t166.*t94.*t17.*t68.*t79.*t11).*t13.*an).*h0;
crea_par(1) = h1(1);
crea_par(2) = h1(2);
crea_par(3) = h1(3);
return;
return;
end %subroutine h1f




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