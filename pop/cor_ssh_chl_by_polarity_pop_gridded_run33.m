clear all

spath='~/matlab/pop/mat/run33_';

pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

load('~/data/eddy/V5/mat/AVISO_25_W_2448910.mat','lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
slat=lat(r,c);
slon=lon(r,c);

% now load pop SSH and CHLdata
load mat/pop_model_domain lat lon
load GS_rings_tracks_run33_sla pop_eddies

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);


SSH=nan(length(slat(:,1)),length(slon(1,:)),length(pdays));
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
          
                      
            SSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear');
            CHL(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp),slon,slat,'linear');
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
           
            
            CHL_a(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp).*amask,slon,slat,'linear');
            CHL_c(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp).*cmask,slon,slat,'linear');
            CHL_t(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp).*tmask,slon,slat,'linear');
            CHL_n(:,:,m)=griddata(plon,plat,hp66_chl(rp,cp).*nmask,slon,slat,'linear');
            
%             figure(1)
%             clf
%             subplot(311)
%             pmap(slon,slat,CHL_a(:,:,m))
%             subplot(312)
%             pmap(slon,slat,CHL_c(:,:,m))
%             subplot(313)
%             pmap(slon,slat,CHL_t(:,:,m))
%             drawnow
            
            clear *ssh *chl
        end
    end
end

save pop_hp66_ssh_and_hp66_chl_by_polarity_gridded_run33 slat slon pdays CHL SSH CHL_a CHL_c CHL_t CHL_n

load pop_hp66_ssh_and_hp66_chl_by_polarity_gridded_run33
lags=-5:5;

[r0,ar0,cr0,N,aN,cN]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(lags)));
for m=1:length(slat(:,1))
    for n=1:length(slon(1,:))
        [r0(m,n,:),dum,N(m,n,:),dd]=pcor(squeeze(CHL(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [ar0(m,n,:),dum,aN(m,n,:),dd]=pcor(squeeze(CHL_a(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [cr0(m,n,:),dum,cN(m,n,:),dd]=pcor(squeeze(CHL_c(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [tr0(m,n,:),dum,tN(m,n,:),dd]=pcor(squeeze(CHL_t(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [nr0(m,n,:),dum,nN(m,n,:),dd]=pcor(squeeze(CHL_n(m,n,:))',squeeze(SSH(m,n,:))',lags);
    end
end

save pop_bec_cor_0_run33_gridded *r0 *N slon slat