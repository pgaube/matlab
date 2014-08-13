tbins=0:.1:5;
area=pi*tbins.^2;
narea=area(2:end)-area(1:end-1);


a=0;
b=5;
dist = a + (b-a).*rand(1000,1);

a = rand(1000,1)*10000;
b = rand(1000,1)*10000;
for i=1:1000; [ma,ia] = min(abs(b-a(i))); dist(i) = ma; end


[b,n]=phist(dist,tbins)

nn=n./narea;
pdf=100*nn./sum(nn);
cpdf=cumsum(pdf)
figure(1)
clf
stairs(tbins(1:end-1),pdf,'k','linewidth',2)
axis([0 5 0 10])
title('Number of (random) ARGO profiles per unit area')
ylabel('%')
xlabel('eddy radi (L_s)')
grid
niceplot
print -dpng -r300 figs/random_histo_prof_log_rad
figure(2)
title('Cumulative PDF of ARGO profiles per unit area')
stairs(tbins(1:end-1),cpdf,'k')
