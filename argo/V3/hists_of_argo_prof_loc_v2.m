clear all
%first do the OBS
load eddy_argo_prof_index_rad
 
jdays=unique(eddy_pjday_round);
lj=length(jdays);

lss=length(eddy_scale);
ledd=1802858; %this many eddy realizations during argo record per jday

tbins=0:.1:5;
area=pi*tbins.^2;
narea=area(2:end)-area(1:end-1);

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);

[b,n]=phist(dist,tbins);

nn=n./narea;
pdf=100*nn./sum(nn);
cpdf=cumsum(pdf);

%
%now do the random data
% a test to see if argo floats randomly seeded in a global domain, randomly
% subsample all the observations and then calculate the same dist and histo


id=ceil(rand(lss,1)*lss);
pjday = eddy_pjday(id);
pjday = eddy_pjday;
id=ceil(rand(lss,1)*lss);
plat  = eddy_plat(id);
id=ceil(rand(lss,1)*lss);
plon  = eddy_plon(id);

%next make random eddy locations
id=ceil(rand(ledd,1)*lss);
elon = eddy_x(id);
id=ceil(rand(ledd,1)*lss);
elat  = eddy_y(id)';
id=ceil(rand(ledd,1)*lss);
scale  = eddy_scale(id);
id=ceil(rand(ledd,1)*lss);
ejday  = eddy_pjday(id);
ejday  = eddy_pjday;

figure(1)
clf
subplot(321)
hist(eddy_plat)
subplot(322)
hist(plat)

subplot(323)
hist(eddy_plon)
subplot(324)
hist(plon)

subplot(325)
hist(eddy_scale)
subplot(326)
hist(scale)

dist=nan*plat;

plp=1;
for m=1:lj
    iee=find(ejday==jdays(m));
    ipp=find(pjday==jdays(m));
    tplat=plat(ipp);
    tplon=plon(ipp);
    telat=elat(iee);
    telon=elon(iee);
    tscale=scale(iee);
    for jj=1:length(ipp)
        dist_y=telat-tplat(jj);
        dist_y=dist_y';
        dist_x=telon-tplon(jj);
        dist(plp) = min(sqrt((111.11*cosd(tplat)*dist_x./tscale).^2+(111.11*dist_y./tscale).^2)); %dist in units of eddy radial scale
        plp=plp+1;
    end
end



% clear dist
% load random_profiles dist
[rb,rn]=phist(dist,tbins);

rnn=rn./narea;
rpdf=100*rnn./sum(rnn);
rcpdf=cumsum(rpdf);


figure(1)
clf
stairs(tbins(1:end-1),nn,'k','linewidth',2)
hold on
stairs(tbins(1:end-1),rnn,'k--','linewidth',2)
title('Number of ARGO profiles per unit area')
ylabel('N(r)/area(r)')
xlabel('eddy radi (L_s)')
grid
niceplot
legend('observations','random')
% print -dpng -r300 figs/histo_number_global_and_random_v2


figure(2)
clf
stairs(tbins(1:end-1),cpdf,'k','linewidth',2)
hold on
stairs(tbins(1:end-1),rcpdf,'k--','linewidth',2)
ylabel('%')
xlabel('eddy radi (L_s)')
grid
niceplot
legend('observations','random')
title('Cumulative PDF of ARGO profiles per unit area')

% print -dpng -r300 figs/chisto_number_global_and_random_v2

figure(3)
clf
plot(tbins(1:end-1),cpdf./rcpdf,'k','linewidth',2)
ylabel('ratio (obs/random)')
xlabel('eddy radi (L_s)')
grid
niceplot
axis([0 5 1 2.5])
line([0 5],[1 1],'color',[.5 .5 .5],'linewidth',2)
title('ratio of observations to random CPDF')
% print -dpng -r300 figs/ratio_number_global_and_random_v2




