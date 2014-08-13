function [a,b,alpha,p,chiopt,Cab,Calphap]=...
    ols_line(varargin);
% function [a,b,alpha,p,chiopt,Cab,Calphap]=...
%   ls_line(xin,yin,a_guess);
%
% othogonal least squares (ols) fit of a straigth line 
% to a set of points
%
% input:        xin     abscissa vector
%               yin     ordinate vector
%
% output:       a, b    usual straight line parameters
%                       y=a*x+b
%               alpha,p more stable parametrisation
%                       y*cos(alpha)-x*sin(alpha)-p=0
%                       alpha: slope angle in radians
%                       p: distance of straight line from (0,0)
%                       conversion: a=tan(alpha),b=p/cos(alpha)
%               chiopt  minimum chisquare found
%               Cab     covariances, [var(a),var(b),cov(a,b)]
%               Calphap covariances, [var(alpha),var(p),cov(alpha,p)]
%
% algorithm:    Peter Gaube modifed the original wtls_line.m algorithum written by 
%				M. Krystek & M. Anton
%               Physikalisch-Technische Bundesanstalt Braunschweig, Germany
%               Meas. Sci. Tech. 18 (2007), pp3438-3442
%
% tested for Matlab 6 and Matlab 7
%
% 2007-03-08

tol=1e-6; %"tolerance" parameter of fnimbnd, see there
xin=double(varargin{1});
yin=double(varargin{2});

global x y
% inputs
% force column vectors
x=xin(:);
y=yin(:);

% "initial guess": 
if nargin<3
	p0=polyfit(x,y,1);
	alpha0=atan(p0(1));
else
	alpha0=atan(varargin{3});
end	


% one-dimensional search, use p=p^
[alphaopt,chiopt,exitflag] = ...
    fminbnd(@chialpha,alpha0-pi/2,alpha0+pi/2,optimset('TolX',tol));

% get optimum p from alphaopt
alpha=alphaopt;
uk2=sin(alpha)^2+cos(alpha)^2;
u2=1./pmean(1./uk2);
w=u2./uk2;
xbar=pmean(w.*x);
ybar=pmean(w.*y);
p=ybar*cos(alpha)-xbar*sin(alpha);
% convert to a, b parameters y=a*x+b
a=sin(alpha)/cos(alpha);
b=p/cos(alpha);
% --- uncertainty calculation, covariance matrix = 2*inv(Hessian(chi2)) ---
n=length(x);
vk=y.*cos(alpha)-x*sin(alpha)-p;
vka=-y*sin(alpha)-x*cos(alpha);
vkaa=-vk-p;
fk=vk.*vk;
fka=2*vk.*vka;
fkaa=2*(vka.^2+vk.*vkaa);
gk=uk2;
gka=2*sin(alpha)*cos(alpha)*0;
gkaa=2*0*(cos(alpha)^2-sin(alpha)^2);
Hpp=2*n/u2;
Halphap=-2*sum((vka.*gk-gka.*vk)./gk.^2);
Halphaalpha=...
    sum(fkaa./gk-2*fka.*gka./gk.^2+2*gka.^2.*fk./gk.^3-gkaa.*fk./gk.^2);
NN=2/(Hpp*Halphaalpha-Halphap^2);
var_p=NN*Halphaalpha;
var_alpha=NN*Hpp;
cov_alphap=-NN*Halphap;
Calphap=[var_alpha,var_p,cov_alphap];
% ------ convert to a & b covariance matrix, following DIN 1319 (4)
var_a=var_alpha/cos(alpha)^4;
var_b=(var_alpha*p*p*sin(alpha)^2+var_p*cos(alpha)^2+...
    2*cov_alphap*p*sin(alpha)*cos(alpha))/cos(alpha)^4;
cov_ab=(var_alpha*p*sin(alpha)+cov_alphap*cos(alpha))/cos(alpha)^4;
Cab=[var_a,var_b,cov_ab];
% ------ end of uncertainty calculation -----------------------------------
return

% ------------------ subfunction ------------------------------------------
function chi=chialpha(alpha)
    global x y
    uk2=sin(alpha)^2+cos(alpha)^2;
    u2=1./pmean(1./uk2);
    w=u2./uk2;
    xbar=pmean(w.*x);
    ybar=pmean(w.*y);
    p=ybar*cos(alpha)-xbar*sin(alpha);
    chi=sum((y*cos(alpha)-x*sin(alpha)-p).^2./uk2);
return
% ----------- end of subfunction ------------------------------------------
