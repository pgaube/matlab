clear all
%first do the OBS
load eddy_argo_prof_index_rad

figure(1)
clf
hist(eddy_scale);
lss=length(eddy_scale);
title('obs')

mu=pmean(eddy_scale);
cc=cov(eddy_scale);
 
jdays=unique(eddy_pjday_round);
lj=length(jdays);
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
% a test to see if argo floats randomly seeded in a global domain, then subsampled and colocated with randomly
% distributed eddies of random size (radial scales) have the same probability densit function, per unit area, 
% as observed floats within real eddies.

[pjday,ejday,plat,plon,elat,elon,scale]=deal(nan(1));
%start out making random float profile locations, distibuted between 60N,60S, 0E-360E
a=-60;
b=60;
n=round(length(eddy_x)/lj); %about this many argo profiles per jday
for m=1:lj
    tt = a + (b-a).*rand(n,1);
    plat=cat(1,plat,tt);
    tt=jdays(m)*ones(length(tt),1);
    pjday=cat(1,pjday,tt);
end    

a=0;
b=360;
for m=1:lj
    tt = a + (b-a).*rand(n,1);
    plon=cat(1,plon,tt);
end    


%next make random eddy locations
a=-60;
b=60;
ne=round(1802858/lj); %this many eddy realizations during argo record per jday
for m=1:lj
    tt = a + (b-a).*rand(ne,1);
    elat=cat(1,elat,tt);
    tt=jdays(m)*ones(length(tt),1);
    ejday=cat(1,ejday,tt);
end    


a=0;
b=360;
for m=1:lj
    tt = a + (b-a).*rand(ne,1);
    elon=cat(1,elon,tt);
end  


%random eddy radi
a=60; %km
b=120; %km
for m=1:lj
    tt=a + (b-a).*rand(ne,1);
    scale=cat(1,scale,tt);
end  

figure(2)
clf
hist(scale)
title('random')

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
        dist_x=telon-tplon(jj);
        dist(plp) = min(sqrt((111.11*cosd(plat(jj))*dist_x./tscale).^2+(111.11*dist_y./tscale).^2)); %dist in units of eddy radial scale
        plp=plp+1;
    end
end

save random_profiles dist_y dist_x dist
%}

clear dist
load random_profiles dist
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
print -dpng -r300 figs/histo_number_global_and_random


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

print -dpng -r300 figs/chisto_number_global_and_random

figure(3)
clf
plot(tbins(1:end-1),cpdf./rcpdf,'k','linewidth',2)
ylabel('ratio (obs/random)')
xlabel('eddy radi (L_s)')
grid
niceplot
axis([0 5 .5 1.5])
line([0 5],[1 1],'color',[.5 .5 .5],'linewidth',2)
title('ratio of observations to random number of profiles per unit area')
print -dpng -r300 figs/ratio_number_global_and_random




