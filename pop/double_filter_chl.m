
spath='~/matlab/pop/mat/run14_';
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];

%
% now load pop SSH data
load ~/matlab/pop/mat/pop_model_domain.mat lat lon mask1


load([spath,num2str(pdays(1))],'total_chl')
mask=nan*mask1;
mask(mask1>0)=1;
buff_mask=buffnan_rad(mask,10);

save -append ~/matlab/pop/mat/pop_model_domain.mat buff_mask
CHL=nan(length(lat(:,1)),length(lon(1,:)),length(pdays));


for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'total_chl')
        if exist('total_chl')
            m
            CHL(:,:,m)=total_chl.*buff_mask;
            clear total_chl
        end
    end
%     figure(1)
%     clf
%     pmap(lon,lat,real(log10(CHL(:,:,m))));
%     title(num2str(m))
%     caxis([-1.5 .5])
%     drawnow

end

save tmp_chl lat lon pdays CHL
% return
tmp_jdays=linspace(1,5*length(pdays),length(pdays));

load tmp_chl
ss_CHL=nan*CHL;
for m=1:length(lat(:,1))
    for n=1:length(lon(1,:))
        tmp=squeeze(CHL(m,n,:));
        ss_CHL(m,n,:)=harm_reg(tmp_jdays,tmp,2,2*pi/365.25);
    end
end

ds_CHL=CHL-ss_CHL;

save tmp_chl lat lon pdays CHL ss_CHL ds_CHL

load tmp_chl ds_CHL lat lon pdays

load ~/data/gsm/cor_chl_ssh_out.mat lon lat
glon=lon;
glat=lat;
load tmp_chl ds_CHL lat lon pdays
[rg,cg]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
glat=glat(rg,cg);
glon=glon(rg,cg);


for m=1:length(pdays)
    m
    ttt=griddata(lon,lat,ds_CHL(:,:,m),glon,glat,'linear');
    
    %%smooth
    tic
    lp=smooth2d_loess(ttt,glon(1,:),glat(:,1),6,6,glon(1,:),glat(:,1));
    toc
    
    %%grid 2
    lph=griddata(glon,glat,lp,lon,lat,'linear');
    
    ss66_chl=ds_CHL(:,:,m)-lph;
    
%     figure(1)
%     clf
%     pmap(plon,plat,ss66_chl);
%     title(num2str(m))
%     caxis([-.1 .1])
%     drawnow
%     
    eval(['save -append mat/run14_',num2str(pdays(m)),' ss66_chl'])
end



