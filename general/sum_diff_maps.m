function [sum_k_prime,sum_k_bar] = sum_diff_maps(fine,smooth);


a_dif=abs(fine-smooth);
dif=(fine-smooth);	


i=~isnan(dif);
g=dif(i);
g=g(:);
dif=sum(g);

i=~isnan(a_dif);
g=a_dif(i);
g=g(:);
a_dif=sum(g);


i=~isnan(smooth);
h=smooth(i);
h=h(:);
k_bar=sum(h);

Percent_Differance = abs((dif/k_bar)*100)
Percent_Differance_abs = (a_dif/k_bar)*100