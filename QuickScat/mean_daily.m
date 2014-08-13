% clear all
% close all
% mon_str={'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'};
% data_in='qscat.crlstr'
% 
% 
startjd=date2jd(2002,7,11)+.5;
endjd=date2jd(2009,11,4)+.5;
% path_in='/Users/new_gaube/data/QuickScat/from_larry/oct12_exp22_qscat_'
% 
% 
% load /Users/new_gaube/data/QuickScat/from_larry/oct12_exp22_qscat_aug2003-output.mat
% lat=qscat.lat;
% lon=qscat.lon;
% 
% [rrr,ccc]=imap(15,25,165,195,lat,lon);
% jdays=[startjd:endjd];
% cname='t';
% load_path = path_in;
% 
% mean_crl=single(nan(length(lat),length(lon),length(jdays)));
% 
% [lon,lat]=meshgrid(lon,lat);
% 
% for m=1:length(jdays)
%     [year,month,day]=jd2jdate(jdays(m));
%     fname = [load_path mon_str{month} num2str(year) '-output.mat']
%     fprintf('\r     io file %03u of %03u \r',m,length(jdays))
%     tesst=strcmp(fname,cname);
%     if tesst~=1
%         if exist(fname)
%             load(fname)
%             [dud,dud,ddd]=datevec(qscat.datenum);
%         else
%             fprintf('\r missing file \n')
%             fname
%             eval([data_in '= nan(560,1440);'])
%             display('no file')
%         end
%     end
%     zp=find(ddd==day);
%     if any(zp)
%         mean_crl(:,:,m)=single(qscat.crlstr(:,:,zp));
% %         figure(1)
% %         clf
% %         pmap(lon(rrr,ccc),lat(rrr,ccc),1e7*qscat.crlstr(rrr,ccc,zp))
% %         m_plot(180,20,'k*','markersize',30)
% %         caxis([-5 5])
% %         pause(.2)
%         cname=fname;
%     else
%         clear ddd
%         display('no day')
%     end
% end
% 
% save mean_daily lat lon jdays mean_crl
% 
% mean_crlstr=nanmean(mean_crl,3);
% clearallbut mean_crlstr lat lon
% 
% save -append mean_daily lat lon jdays mean_crlstr
% 
load mean_daily lat lon jdays mean_crlstr
% 
figure(1)
clf
pmap(lon,lat,1e7*mean_crlstr)
colorbar
caxis([-3 3])
load bwr.pal
caxis
colormap(bwr)
hold on
m_contour(lon,lat,1e7*mean_crlstr,[-1 1],'k','linewidth',.5)

print -dpng -r300 mean_daily_crlstr



wek=mean_crlstr./1020./f_cor(lat)*60*60*24*100;

figure(2)
clf
pmap(lon,lat,wek)
caxis([-50 50])
load bwr.pal
colorbar
caxis
colormap(bwr)
hold on
m_contour(lon,lat,wek,[-5 5],'k','linewidth',.5)
print -dpng -r300 mean_daily_wek

