clear all
load bwr.pal
load GAUBE_region_comps
curs = {'CAR','EIO','HAW','new_SP','AGU','AGR','MID'};


for mm=1:6
    eval(['ssh_a(:,:,mm)=',curs{mm},'_ssh_a.mean;'])
    eval(['ssh_c(:,:,mm)=',curs{mm},'_ssh_c.mean;'])
    eval(['crl_a(:,:,mm)=abs(',curs{mm},'_crlg_a.mean);'])
    eval(['crl_c(:,:,mm)=abs(',curs{mm},'_crlg_c.mean);'])
end


clearallbut curs ssh_a ssh_c crl_a crl_c

zgrid_grid
dd=dist;
ri=0:.125:2.5

for m=1:6
    clear tmpa tmpc
    tmpa=ssh_a(:,:,m);
    tmpc=ssh_c(:,:,m);
    for n=1:length(ri)-1
        az_a(m,n)=pmean(tmpa(dist>=ri(n) & dist<ri(n+1)));
        az_c(m,n)=pmean(tmpc(dist>=ri(n) & dist<ri(n+1)));
    end
    clear tmpa tmpc
    tmpa=crl_a(:,:,m);
    tmpc=crl_c(:,:,m);
    for n=1:length(ri)-1
        azc_a(m,n)=pmean(tmpa(dist>=ri(n) & dist<ri(n+1)));
        azc_c(m,n)=pmean(tmpc(dist>=ri(n) & dist<ri(n+1)));
    end
end


x=1000*[-500:10:500];
y=1000*[-500:10:500];
[lon,lat]=meshgrid(x,y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=.14;
L=90e3; %m
xo=0;
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

h=a*exp((-dist.^2)/(2*L^2));
hh=zgrid_abs(real_lon,real_lat,30,30,double(h),L/1000*1.64);

load GAUBE_midlat_ssh_comps ssh_a ssh_c
for n=1:length(ri)-1
    ml_a(n)=pmean(ssh_a.mean(dd>=ri(n) & dd<ri(n+1)));
    ml_c(n)=pmean(ssh_c.mean(dd>=ri(n) & dd<ri(n+1)));
end


colors=('mcrgb')
figure(1)
clf
set(gcf,'PaperPosition',[1 1 3 4])
hold on
for m=1:5
    plot(ri(1:end-1),az_a(m,:),'color',colors(m))
end
plot(ri(1:end-1),az_a(6,:),'color',[.5 .5 .5])
plot(ri(1:end-1),ml_a,'k','linewidth',3)
plot(dd(17,:),100*hh(17,:),'k','linewidth',1)

set(gca,'xlim',[0 2],'xtick',[0:.5:2])
line([0 2],[0 0],'color','k','linewidth',2,'linestyle','--')
box
set(gca,'fontsize',11,'fontweight','bold','LineWidth',1,'TickLength',[.02 .04],'layer','top')
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID','Gaussian')
set(cc,'box','off')

print -dpng -r300 figs/ssh_az_ave_new


figure(2)
clf
set(gcf,'PaperPosition',[1 1 3 4])
hold on
for m=1:5
    plot(ri(1:end-1),az_a(m,:)./az_a(m,1),'color',colors(m))
end
plot(ri(1:end-1),az_a(6,:)./az_a(6,1),'color',[.5 .5 .5])
plot(ri(1:end-1),ml_a./ml_a(1),'k','linewidth',3)
plot(dd(17,:),hh(17,:)./hh(17,17),'k','linewidth',1)

set(gca,'xlim',[0 2],'xtick',[0:.5:2])
line([0 2],[0 0],'color','k','linewidth',2,'linestyle','--')
box
set(gca,'fontsize',11,'fontweight','bold','LineWidth',1,'TickLength',[.02 .04],'layer','top')
% cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID','Gaussian')
% set(cc,'box','off')

print -dpng -r300 figs/ssh_az_ave2_new

dgdx=dfdx_abs(hh(17,:),1);
dmdx=dfdx_abs(ml_a,1);

figure(3)
clf
plot(dd(17,:),dgdx);
hold on
plot(ri(1:end-1),dmdx,'b');



