clear all

spath='~/matlab/pop/mat/run33_';

pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

% now load pop SSH and CHLdata
load mat/pop_model_domain lat lon
load GS_rings_tracks_run33_sla pop_eddies pdays

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);


SSH=nan(length(plat(:,1)),length(plon(1,:)),length(pdays));
CHL=SSH;
CHL_a=CHL;
CHL_c=CHL;
CHL_t=CHL;
CHL_n=CHL;

% 
for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'bp21_ssh','hp66_chl')
        if exist('bp21_ssh')
            SSH(:,:,m)=bp21_ssh(rp,cp);
            CHL(:,:,m)=hp66_chl(rp,cp);
            ii=find(pop_eddies.jdays==pdays(m))
            mask=pop_eddies.mask(:,:,ii);
            amask=nan*mask;
            ia=find(pop_eddies.track_jday==pdays(m) & pop_eddies.cyc==1);
            for ike=1:length(ia)
                amask(mask==pop_eddies.eid(ia(ike)))=1;
            end
            
            cmask=nan*mask;
            ic=find(pop_eddies.track_jday==pdays(m) & pop_eddies.cyc==-1);
            for ike=1:length(ic)
                cmask(mask==pop_eddies.eid(ic(ike)))=1;
            end
            tmask=nan*mask;
            tmask(~isnan(mask))=1;
            
            nmask=nan*mask;
            nmask(isnan(mask))=1;
%             figure(1)
%             clf
%             subplot(311)
%             pcolor(mask);shading flat;axis image
%             subplot(312)
%             pcolor(amask);shading flat;axis image
%             subplot(313)
%             pcolor(cmask);shading flat;axis image
%             drawnow
            
            CHL_a(:,:,m)=hp66_chl(rp,cp).*amask;
            CHL_c(:,:,m)=hp66_chl(rp,cp).*cmask;
            CHL_t(:,:,m)=hp66_chl(rp,cp).*tmask;
            CHL_n(:,:,m)=hp66_chl(rp,cp).*nmask;
            clear *ssh *chl
        end
    end
end

save pop_hp66_ssh_and_hp66_chl_by_polarity_run_33 plat plon pdays CHL SSH CHL_a CHL_c CHL_t CHL_n

load pop_hp66_ssh_and_hp66_chl_by_polarity_run_33
lags=-5:5;

[r0,ar0,cr0,N,aN,cN]=deal(nan(length(plat(:,1)),length(plon(1,:)),length(lags)));
for m=1:length(plat(:,1))
    for n=1:length(plon(1,:))
        [r0(m,n,:),dum,N(m,n,:),dd]=pcor(squeeze(CHL(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [ar0(m,n,:),dum,aN(m,n,:),dd]=pcor(squeeze(CHL_a(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [cr0(m,n,:),dum,cN(m,n,:),dd]=pcor(squeeze(CHL_c(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [tr0(m,n,:),dum,tN(m,n,:),dd]=pcor(squeeze(CHL_t(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [nr0(m,n,:),dum,nN(m,n,:),dd]=pcor(squeeze(CHL_n(m,n,:))',squeeze(SSH(m,n,:))',lags);
    end
end

save pop_bec_cor_0_run_33 *r0 *N plon plat