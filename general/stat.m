%calculates the Corralation and covrance
%of arrays X and Y
% Copyright(C) P,Gaube 6 November 2004
function [cor,cov] = stat(c,t)


%assign x variabelts to the X set
X=c(:);
Y=t(:);
i = find(~isnan(X) & ~isnan(Y));
X=X(i);
Y=Y(i);
xbar=mean(X);
sdx=std(X);
xx=X-xbar;

%assign y variabelts to the Y set;
ybar=mean(Y);
sdy=std(Y);
yy=Y-ybar;

%Calculate covarance of X and Y
%covar=(1/(m-1))*sum((xi-xbar)*(ybar-yi))
cov=mean(xx.*yy)

%calculate correlation of X and
%Y

cor=cov/(sdx*sdy)
cor_squared=cor^2
N=length(X)
meanT=ybar
meanC=xbar

