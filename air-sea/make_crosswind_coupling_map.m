clear all
close all

jdays=[2452459:7:2454706];%[2451556:7:2454797];
lj=length(jdays);

% qsave_path='~/data/QuickScat/new_mat/';
% qsave_head='QSCAT_30_25km_';
% 
% load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
% 
% load(['~/data/QuickScat/mat/' qsave_head num2str(jdays(1))],'mask')
% 
% [year,month,day]=jd2jdate(jdays(1:lj));
%
% DTDN=single(nan(560,1440,lj));
% CRL=DTDN;
%
% alpha_n=single(nan(560,1440));
% issig=alpha_n;
%
% for m=1:lj
% 	fprintf('\r    loading %03u of %03u\r',m,lj)
% 	load([qsave_path qsave_head num2str(jdays(m))],'hp66_crlstr','hp66_dtdn','hp66_dtds')
% 	CRL(:,:,m)=single(hp66_crlstr).*mask;
% 	DTDN(:,:,m)=single(hp66_dtds).*mask;
% 	clear hp66*
% end
%
% save -v7.3 all_dtdn_crlstr_Oct_24 lat lon CRL DTDN year month day jdays

% 
% load all_dtdn_crlstr_Oct_24
% slat=lat;slon=lon;
% tbins=-1e-5:.1e-5:1e-5;
% ltb=length(tbins)-1;
% dist=1;
% 
% [alpha_n,issig]=deal(nan(560,1440));
% 
% for mm=1:560
%     fprintf('\r m = %3u',mm)
%     for nn=1:1440
%         if mm<dist+1
%             ros=1:mm+dist;
%         elseif mm>560-dist-1
%             ros=mm-dist:560;
%         else
%             ros=mm-dist:mm+dist;
%         end
%         if nn<dist+1
%             col=1:nn+dist;
%         elseif nn>1440-dist-1
%             col=nn-dist:1440;
%         else
%             col=nn-dist:nn+dist;
%         end
%         n=DTDN(ros,col,:);n=n(:);
%         y=-CRL(ros,col,:);y=y(:);
%         if ~isempty(length(~isnan(n)))
%             binned_samps2=nan(1,ltb);
%             for i=1:ltb
%                 bin_est = find(n>=tbins(i) & n<tbins(i+1));
%                 binned_samps2(i) = double(pmean(y(bin_est)));
%             end
%             [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
%             alpha_n(mm,nn)=Cor*sdY/sdX;
%             if Cor>Sig
%                 issig(mm,nn)=1;
%             end
%         end
%         
%     end
% end
% 
% mean_alpha_n=nanmean(alpha_n,3);
% save coupco_maps_month_oct_24 alpha_n slat slon mean_alpha_n issig

clear
load coupco_maps_month_oct_24
sm_alpha_n=smooth2d_loess(mean_alpha_n,slon(1,:),slat(:,1),10,10,slon(1,:),slat(:,1));
save -append coupco_maps_month_oct_24 sm_alpha_n

[r,c]=imap(-55,55,0,360,slat,slon);
figure(1)
clf
pmap(slon(r,c),slat(r,c),sm_alpha_n(r,c))
caxis([0 .04])
title('\alpha_c^{strcrl}')
draw_air_sea_regions
colorbar
print -dpng -r300 figs/map_of_alpha_n

figure(1)
clf
pmap(slon(r,c),slat(r,c),mean_alpha_n(r,c).*issig(r,c))
caxis([0 .04])
title('\alpha_c^{strcrl}')
draw_air_sea_regions
colorbar
print -dpng -r300 figs/map_of_alpha_n_sig


