function v=pvar(x)

p=~isnan(x);
y=x(p);
v = pmean(y.^2)-pmean(y)^2;