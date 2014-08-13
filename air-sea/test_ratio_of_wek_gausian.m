%test ratios of Ekman pumping from Gaussian eddy
rhoa=1;
a=.1;
l=90e3;
[f,b]=f_cor(30);
ua=7;
cd=1e-3;
g=9.8;
rho=1020;
b=1e-11


wc=3*rhoa*cd*a*g*ua/rho/f^2/l^2*60*60*24*100

wv=4*rhoa*cd*a*g*ua*ua/rho/f^3/l^3*60*60*24*100

wb=b*rhoa*cd*ua*ua/rho/f^2*60*60*24*100

wc/wv
wc/wb