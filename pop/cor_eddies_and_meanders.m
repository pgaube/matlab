clear all
load bwr.pal


fnames={'GS_core_eddies_observed_sla','GS_core_eddies_run14_sla','GS_core_eddies_run33_sla','GS_core_meanders_observed_sla','GS_core_meanders_run14_sla','GS_core_meanders_run33_sla'};
save_names={'observed_eddies','run14_eddies','run33_eddies','observed_meanders','run14_meanders','run33_meanders'};
norths={'mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33','mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33'};

load mean_gs_path_obs_pop_run_33 mean

lags=-5:5;
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

bs=7;
as=2;

load('~/data/eddy/V5/mat/AVISO_25_W_2448910.mat','lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
slat=lat(r,c);
slon=lon(r,c);

load mat/pop_model_domain lat lon
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);

sig_r=.12

for drap=2:length(fnames)
    clearallbut fnames drap norths minlat maxlat minlon maxlon slon slat bwr as bs fig_names lags save_names bwr sig_r bs as r c pdays plon plat rp cp
    if drap==1 | drap==4
        load tmp_ssh_chl_obs
        load(fnames{drap},'stream_eddies')
        load(norths{drap})
        lons=mean(:,1);
        lats=mean(:,2);
        std_lats=std;
        minlat2=30;
        maxlat2=50;
        minlon2=min(mean(:,1));
        maxlon2=max(mean(:,1));
        [rp2,cp2]=imap(minlat,maxlat,minlon,maxlon,slat,slon);
    elseif drap==2 | drap==5
        load pop_run_14_cor_matrix
        load(fnames{drap},'stream_eddies')
        load(norths{drap})
        njdays=pdays;
        [nCHL,nSSH]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(njdays)));
        minlat2=30;
        maxlat2=50;
        minlon2=min(mean(:,1));
        maxlon2=max(mean(:,1));
        [rp2,cp2]=imap(minlat,maxlat,minlon,maxlon,slat,slon);
    elseif drap==2 | drap==5
        load pop_run_33_cor_matrix
        load(fnames{drap},'stream_eddies')
        load(norths{drap})
        njdays=pdays;
        [nCHL,nSSH]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(njdays)));
        minlat2=30;
        maxlat2=50;
        minlon2=min(mean(:,1));
        maxlon2=max(mean(:,1));
        [rp2,cp2]=imap(minlat,maxlat,minlon,maxlon,slat,slon);
    end
    
    [r0,ar0,cr0,tr0,nr0,N,aN,cN,tN,nN]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(lags)));
    [SSH,CHL_AC,CHL_CC,CHL_NO,CHL_ED,CHL]=deal(single(nan(length(r),length(c),length(njdays))));
    
    
    for m=1:length(njdays)
        fprintf('\r    masking %03u of %03u\r',m,length(njdays))      
        ii=find(stream_eddies.jdays==njdays(m));
        if any(ii)
            mask=stream_eddies.mask(:,:,ii);
            amask=nan*mask;
            ia=find(stream_eddies.track_jday==njdays(m) & stream_eddies.cyc==1);
            for ike=1:length(ia)
                amask(mask==stream_eddies.eid(ia(ike)))=1;
            end
            
            cmask=nan*mask;
            ic=find(stream_eddies.track_jday==njdays(m) & stream_eddies.cyc==-1);
            for ike=1:length(ic)
                cmask(mask==stream_eddies.eid(ic(ike)))=1;
            end
            tmask=nan*mask;
            tmask(~isnan(amask))=1;
            tmask(~isnan(cmask))=1;
            
            nmask=nan*mask;
            nmask(isnan(mask))=1;
            
            
            
            CHL(:,:,m)=single(nCHL(:,:,m));
            CHL_AC(:,:,m)=single(nCHL(:,:,m).*amask);
            CHL_CC(:,:,m)=single(nCHL(:,:,m).*cmask);
            CHL_NO(:,:,m)=single(nCHL(:,:,m).*nmask);
            CHL_ED(:,:,m)=single(nCHL(:,:,m).*tmask);
            SSH(:,:,m)=single(nSSH(:,:,m));
            
            
            %         figure(1)
            %         clf
            %         subplot(221)
            %         pmap(slon,slat,nSSH(:,:,m).*amask)
            %         caxis([-40 40])
            %         subplot(222)
            %         pmap(slon,slat,nSSH(:,:,m).*cmask)
            %         caxis([-40 40])
            %         subplot(223)
            %         pmap(slon,slat,nSSH(:,:,m).*tmask)
            %         caxis([-40 40])
            %         subplot(224)
            %         pmap(slon,slat,nSSH(:,:,m).*nmask)
            %         caxis([-40 40])
            %
            %         figure(2)
            %         clf
            %         subplot(221)
            %         pmap(slon,slat,CHL_AC(:,:,m))
            %         caxis([-.1 .1])
            %         subplot(222)
            %         pmap(slon,slat,CHL_CC(:,:,m))
            %         caxis([-.1 .1])
            %         subplot(223)
            %         pmap(slon,slat,CHL_ED(:,:,m))
            %         caxis([-.1 .1])
            %         subplot(224)
            %         pmap(slon,slat,CHL_NO(:,:,m))
            %         caxis([-.1 .1])
        end
        
    end
    
    
    for m=1:length(slat(:,1))
        for n=1:length(slon(1,:))
            [r0(m,n,:),dum,N(m,n,:),dd]=pcor(squeeze(CHL(m,n,:))',squeeze(SSH(m,n,:))',lags);
            [ar0(m,n,:),dum,aN(m,n,:),dd]=pcor(squeeze(CHL_AC(m,n,:))',squeeze(SSH(m,n,:))',lags);
            [cr0(m,n,:),dum,cN(m,n,:),dd]=pcor(squeeze(CHL_CC(m,n,:))',squeeze(SSH(m,n,:))',lags);
            [tr0(m,n,:),dum,tN(m,n,:),dd]=pcor(squeeze(CHL_ED(m,n,:))',squeeze(SSH(m,n,:))',lags);
            [nr0(m,n,:),dum,nN(m,n,:),dd]=pcor(squeeze(CHL_NO(m,n,:))',squeeze(SSH(m,n,:))',lags);
        end
    end
    
    mask=ones(size(r0(rp2,cp2,1)));
    mask(find(isnan(r0(rp2,cp2,6))))=nan;
    sm_r0=smoothn(r0(rp2,cp2,6),3).*mask;
    zero_r0=smoothn(r0(rp2,cp2,6),1).*mask;
    zero_r0(abs(zero_r0)<sig_r)=nan;
    
    figure(1)
    clf
    pmap(slon(rp2,cp2),slat(rp2,cp2),zero_r0,'gs')
    colormap(bwr)
    caxis([-.75 .75])
    hold on
    m_contour(slon(rp2,cp2),slat(rp2,cp2),zero_r0,[-sig_r sig_r],'k')
    ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    eval(['print -dpng -r300 figs/',save_names{drap},'_cor_tot'])
    
    
    mask=ones(size(ar0(rp2,cp2,1)));
    mask(find(isnan(ar0(rp2,cp2,6))))=nan;
    sm_r0a=smoothn(ar0(rp2,cp2,6),3).*mask;
    zero_r0a=smoothn(ar0(rp2,cp2,6),1).*mask;
    zero_r0a(abs(zero_r0a)<sig_r)=nan;
    
    figure(1)
    clf
    pmap(slon(rp2,cp2),slat(rp2,cp2),zero_r0a,'gs')
    colormap(bwr)
    caxis([-.75 .75])
    hold on
    m_contour(slon(rp2,cp2),slat(rp2,cp2),zero_r0a,[-sig_r sig_r],'k')
    ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    eval(['print -dpng -r300 figs/',save_names{drap},'_cor_ac'])
    
    mask=ones(size(cr0(rp2,cp2,1)));
    mask(find(isnan(cr0(rp2,cp2,6))))=nan;
    sm_r0c=smoothn(cr0(rp2,cp2,6),3).*mask;
    zero_r0c=smoothn(cr0(rp2,cp2,6),1).*mask;
    zero_r0c(abs(zero_r0c)<sig_r)=nan;
    
    figure(1)
    clf
    pmap(slon(rp2,cp2),slat(rp2,cp2),zero_r0c,'gs')
    colormap(bwr)
    caxis([-.75 .75])
    hold on
    m_contour(slon(rp2,cp2),slat(rp2,cp2),zero_r0c,[-sig_r sig_r],'k')
    ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    eval(['print -dpng -r300 figs/',save_names{drap},'_cor_cc'])
    
    mask=ones(size(nr0(rp2,cp2,1)));
    mask(find(isnan(nr0(rp2,cp2,6))))=nan;
    sm_r0n=smoothn(nr0(rp2,cp2,6),3).*mask;
    zero_r0n=smoothn(nr0(rp2,cp2,6),1).*mask;
    zero_r0n(abs(zero_r0n)<sig_r)=nan;
    
    figure(1)
    clf
    pmap(slon(rp2,cp2),slat(rp2,cp2),zero_r0n,'gs')
    colormap(bwr)
    caxis([-.75 .75])
    hold on
    m_contour(slon(rp2,cp2),slat(rp2,cp2),zero_r0n,[-sig_r sig_r],'k')
    ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    eval(['print -dpng -r300 figs/',save_names{drap},'_cor_none'])
    
    mask=ones(size(tr0(rp2,cp2,1)));
    mask(find(isnan(tr0(rp2,cp2,6))))=nan;
    sm_r0t=smoothn(tr0(rp2,cp2,6),3).*mask;
    zero_r0t=smoothn(tr0(rp2,cp2,6),1).*mask;
    zero_r0t(abs(zero_r0t)<sig_r)=nan;
    
    figure(1)
    clf
    pmap(slon(rp2,cp2),slat(rp2,cp2),zero_r0t,'gs')
    colormap(bwr)
    caxis([-.75 .75])
    hold on
    m_contour(slon(rp2,cp2),slat(rp2,cp2),zero_r0t,[-sig_r sig_r],'k')
    ax=m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    eval(['print -dpng -r300 figs/',save_names{drap},'_cor_all'])
    
    
    eval(['save ',save_names{drap}, '_cor slat slon njdays nCHL nSSH CHL_AC CHL_CC CHL_ED CHL_NO r0 ar0 cr0 tr0 nr0 sm_* '])
    
    
end
