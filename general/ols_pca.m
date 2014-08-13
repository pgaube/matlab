function beta_ols=ols_pca(x,y);
% function beta_ols=ols_pca(x,y);

beta_ols=nan;
%fucking NaNs!
ii=find(isnan(x));
x(ii)=[];
y(ii)=[];

ii=find(isnan(y));
x(ii)=[];
y(ii)=[];


[m,n]=size(x);
if m>1 | n>1
if m<n
	X=[x;y];
else
	X=[x,y];
end	


C=cov(X);

q=C(1,1)-C(2,2);
beta_ols=(-1/(2*C(1,2)))*(q-sqrt(q^2+4*C(1,2)^2));
end
