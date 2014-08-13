% clear all
% close all
%
jdays=[2452459:7:2454706];%[2451556:7:2454797];
lj=length(jdays);
%
% qsave_path='~/data/QuickScat/new_mat/';
% qsave_head='QSCAT_30_25km_';
%
% load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
%
[year,month,day]=jd2jdate(jdays(1:lj));
%
% DTDN=single(nan(560,1440,lj));
% CRL=DTDN;
% DTDS=CRL;
%
% for m=1:lj
% 	fprintf('\r    loading %03u of %03u\r',m,lj)
% 	load([qsave_path qsave_head num2str(jdays(m))],'hp66_crlstr','hp66_dtdn','hp66_dtds')
%
% 	CRL(:,:,m)=single(hp66_crlstr);
% 	DTDN(:,:,m)=single(hp66_dtdn);
% 	DTDS(:,:,m)=single(hp66_dtds);
% 	clear hp66*
% end
%
% save -v7.3 all_dtdn_crlstr_Oct_18 lat lon CRL DTDN DTDS year month day jdays
%

% load all_dtdn_crlstr_Oct_18
% slat=lat;slon=lon;
% tbins=-1e-5:.1e-5:1e-5;
% dist=4;
% for p=1:12
%     p
%     ii=find(month==p);
%     for mm=1:560
%         fprintf('\r m = %3u',m)
%         for nn=1:1440
%             if mm<dist+1
%                 ros=1:mm+dist;
%             elseif mm>560-dist-1
%                 ros=mm-dist:560;
%             else
%                 ros=mm-dist:mm+dist;
%             end
%             if nn<dist+1
%                 col=1:nn+dist;
%             elseif nn>1440-dist-1
%                 col=nn-dist:1440;
%             else
%                 col=nn-dist:nn+dist;
%             end
%             n=DTDS(ros,col,ii);n=n(:);
%             s=DTDN(ros,col,ii);s=s(:);
%             y=-CRL(ros,col,ii);y=y(:);
%             for i=1:length(tbins)-1
%                 bin_est = find(n>=tbins(i) & n<tbins(i+1));
%                 binned_samps2(i) = double(pmean(y(bin_est)));
%                 num_samps2(i) = length(y(bin_est));
%             end
%             [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
%             alpha_n(mm,nn,p)=Cor*sdY/sdX;
%             
%             for i=1:length(tbins)-1
%                 bin_est = find(s>=tbins(i) & s<tbins(i+1));
%                 binned_samps2(i) = double(pmean(y(bin_est)));
%                 num_samps2(i) = length(y(bin_est));
%             end
%             [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
%             alpha_s(mm,nn,p)=Cor*sdY/sdX;
%         end
%     end
% end
% 
% mean_alpha_n=nanmean(alpha_n,3);
% mean_alpha_s=nanmean(alpha_s,3);
% save coupco_maps_month alpha_n alpha_s slat slon mean_alpha*

clear
load coupco_maps_month
[r,c]=imap(-55,55,0,360,slat,slon);
figure(1)
clf
pmap(slon(r,c),slat(r,c),mean_alpha_n(r,c))
caxis([0 .04])
title('\alpha_c^{strcrl}')
draw_air_sea_regions
colorbar
print -dpng -r300 figs/map_of_alpha_n
return

% 
% clf
% pmap(slon(r,c),slat(r,c),mean_alpha_s(r,c))
% caxis([-.01 .01])
% title('\alpha_d^{strcrl}')
% colorbar
% print -dpng -r300 figs/map_of_alpha_s
% return
% 
% 














%%%time series
load all_dtdn_crlstr_Oct_18
slat=lat;slon=lon;
tbins=-1e-5:.1e-5:1e-5;

curs_names = {'South Pacific Ocean',...
    'Agulhas Return Current',...
    'Hawaiian Ridge',...
    'South Indian Ocean',...
    'Caribbean Sea',...
    'Southeast Atlantic Ocean'};
curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU'};

for ee=1:length(curs)
    eval(['load ~/matlab/domains/',curs{ee},'_lat_lon'])
    [r,c]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
    f=2*pi/365.25;
    x=1:365;
    tbins=-1e-5:.1e-5:1e-5;
    
    for m=1:lj
        n=DTDS(r,c,m);n=n(:);
        s=DTDN(r,c,m);s=s(:);
        y=-CRL(r,c,m);y=y(:);
        
        for i=1:length(tbins)-1
            bin_est = find(n>=tbins(i) & n<tbins(i+1));
            binned_samps2(i) = double(pmean(y(bin_est)));
            num_samps2(i) = length(y(bin_est));
        end
        [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
        alpha_n(m)=Cor*sdY/sdX;
        
        for i=1:length(tbins)-1
            bin_est = find(s>=tbins(i) & s<tbins(i+1));
            binned_samps2(i) = double(pmean(y(bin_est)));
            num_samps2(i) = length(y(bin_est));
        end
        [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
        alpha_s(m)=Cor*sdY/sdX;
    end
    
    [ss_alpha_n,beta_n]=harm_reg(jdays,alpha_n,2,2*pi/365.25);
    [ss_alpha_s,beta_s]=harm_reg(jdays,alpha_s,2,2*pi/365.25);
    
    sm_alpha_n=smooth1d_loess(alpha_n,jdays,50,jdays);
    sm_alpha_s=smooth1d_loess(alpha_s,jdays,50,jdays);
    
    ssm_alpha_n=smooth1d_loess(alpha_n,jdays,1000,jdays);
    
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 11 8.5])
    subplot(211)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','clipping','off')
    plot(jdays,sm_alpha_n,'k');
    hold on
    plot(jdays,ss_alpha_n,'b','linewidth',1);
    plot(jdays,ssm_alpha_n,'r');
    plot(jdays,.01*ones(size(jdays)),'g')
    axis([2452459 2454706 -.01 .04])
    ylabel('\alpha_c^{strcrl}','fontsize',20)
    set(gca,'xtick',[jdays(27):365:max(jdays)],'xticklabel',year(27:53:end))
    text(2452459,.044,curs_names(ee),'fontsize',25)
    line([jdays(1) jdays(end)],[0 0],'color',[.5 .5 .5])
    text(2453850,.043,['mean \alpha_c^{strcrl} =',num2str(.001*round(1000*pmean(alpha_n)))],'fontsize',18)
    text(2454500,.044,['% var =',num2str(.01*round(10000*(pstd(ss_alpha_n)/pstd(alpha_n))))],'fontsize',18)
    
    subplot(212)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','clipping','off')    
    plot(jdays,sm_alpha_s,'k');
    hold on
    plot(jdays,ss_alpha_s,'b','linewidth',1);
    plot(jdays,.002*ones(size(jdays)),'g')
    axis([2452459 2454706 -.02 .02])
    ylabel('\alpha_d^{strcrl}','fontsize',20)
    set(gca,'xtick',[jdays(27):365:max(jdays)],'xticklabel',year(27:53:end))
    line([jdays(1) jdays(end)],[0 0],'color',[.5 .5 .5])
    text(2453850,.023,['mean \alpha_d^{strcrl} =',num2str(.0001*round(10000*pmean(alpha_s)))],'fontsize',18)
    text(2454500,.023,['% var =',num2str(.01*round(10000*(pstd(ss_alpha_s)/pstd(alpha_s))))],'fontsize',18)

    eval(['print -dpng -r300 figs/region_coupco_ts_',curs{ee}])
    
end

