X = mvnrnd([0 0], [1.1 .5; .5 1.2],50000);
clf
%scatter(X(:,1),X(:,2))
[coeff,score,roots] = princomp(X);
pctExplained = roots' ./ sum(roots)
meanX = mean(X,1);
Xfit1 = score(:,1)*coeff(:,1)';
hold on
plot(Xfit1(:,1),Xfit1(:,2))
slope_pc=coeff(2,1)/coeff(1,1);
slope_ols=ols_line(X(:,1),X(:,2),1)

C=cov(X);
ang=.5*atan(2*C(1,2)/(C(1,1)-C(2,2)));

q=C(1,1)-C(2,2);
m=(-1/(2*C(1,2)))*(q-sqrt(q^2+4*C(1,2)^2))