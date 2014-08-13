xi=[-2:.125:2];
xi=ones(length(xi),1)*xi;
yi=xi';


xi=interp2(xi,2);
yi=interp2(yi,2);