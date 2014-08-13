% clear all
% mon_str={'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'};
% data_in='qscat.crlstr'
% 
% 
% startjd=date2jd(2003,1,1)+.5;
% endjd=date2jd(2003,12,31)+.5;
% path_in='/Users/new_gaube/data/QuickScat/from_larry/oct12_exp22_qscat_'
% 
% 
% load /Users/new_gaube/data/QuickScat/from_larry/oct12_exp22_qscat_aug2003-output.mat
% lat=qscat.lat;
% lon=qscat.lon;
% [lon,lat]=meshgrid(lon,lat);
% [r,c]=imap(20.1,20.2,180.1,180.2,lat,lon);
% [rrr,ccc]=imap(15,25,165,195,lat,lon);
% jdays=[startjd:endjd];
% cname='t';
% load_path = path_in;
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
%         eval(['ts(m)=single(' data_in '(r,c,zp));'])
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
% sm_ts=smooth1d_loess(ts,1:365,3,1:365);

figure(1)
clf
plot(1:365,-1e7*ts,'linewidth',1)
set(gca,'xtick',[0:40:360])
line([1 365],[0 0],'color','k')
axis([1 365 -10 5])
daspect([180 60 1])
print -dpng -r300 test

ts(isnan(ts))=1e35;
tt(:,1)=jdays
tt(:,2)=ts
save -ascii 2003_crlstr.txt tt