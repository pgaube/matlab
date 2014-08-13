clear all
% load chelle.pal
% jday=date2jd(2002,8,7)+.5;
load ~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_2452494
load ~/data/QuickScat/new_mat/QSCAT_30_25km_2452494
load ~/data/QuickScat/mat/QSCAT_30_25km_2452494 dtds_week

!rm gaube_*.txt

slat=lat(:,1);
nlon=lon(1,:);
dx=.25;dy=.25;
% 
nlat=-79.8750:dy:79.8750;

nx=int(length(nlon));
ny=int(length(nlat));
% 
% fid = fopen('gaube_curl.txt', 'wt');
% 
% tt=[0 360 -80 80];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% tt=[1440 640 .25 .25];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% 
% %crlstr
% dd=griddata(nlon,slat',double(crlstr_week),nlon,nlat');
% dd(isnan(dd))=1e35;
% dd=dd';
% for m=1:nx
%     fprintf(fid, '%e ', dd(m,:));
%     fprintf(fid,'\n');
% end
% clear dd
% fclose(fid)
% 
% fid = fopen('gaube_t_x.txt', 'wt');
% 
% ttt=[0 360 -80 80];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% tt=[1440 640 .25 .25];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% 
% %taux
% dd=griddata(nlon,slat',double(taux_week),nlon,nlat');
% dd(isnan(dd))=1e35;
% dd=dd';
% for m=1:nx
%     fprintf(fid, '%e ', dd(m,:));
%     fprintf(fid,'\n');
% end
% clear dd
% fclose(fid)
% 
% fid = fopen('gaube_t_y.txt', 'wt');
% 
% tt=[0 360 -80 80];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% tt=[1440 640 .25 .25];
% fprintf(fid, '%d ', tt);
% fprintf(fid,'\n');
% 
% %tauy
% dd=griddata(nlon,slat',double(tauy_week),nlon,nlat');
% dd(isnan(dd))=1e35;
% dd=dd';
% for m=1:nx
%     fprintf(fid, '%e ', dd(m,:));
%     fprintf(fid,'\n');
% end
% clear dd
% fclose(fid)

fid = fopen('gaube_w_x.txt', 'wt');

tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');

%u
dd=griddata(nlon,slat',double(u_week),nlon,nlat');
save test_u nlon nlat dd
dd(isnan(dd))=1e35;
dd=dd';
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)

fid = fopen('gaube_w_y.txt', 'wt');
tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');

%v
dd=griddata(nlon,slat',double(v_week),nlon,nlat');
save test_v nlon nlat dd
dd(isnan(dd))=1e35;
dd=dd';
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)
return
fid = fopen('gaube_w_xl.txt', 'wt');

tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');

%sm_u
dd=griddata(nlon,slat',double(sm_u_week),nlon,nlat');
dd(isnan(dd))=1e35;
dd=dd';
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)

fid = fopen('gaube_w_yl.txt', 'wt');

tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');

%sm_v
dd=griddata(nlon,slat',double(sm_v_week),nlon,nlat');
dd(isnan(dd))=1e35;
dd=dd';
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)

fid = fopen('gaube_cr.txt', 'wt');

tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');


% %%%%test
% 
% tt=smooth2d_loess(double(dtds_week),nlon,slat',6,6,nlon,slat');
% hp=dtds_week-tt;
% figure(1)
% clf
% pmap(nlon,slat,1e7*hp);caxis([-1 1])
% 
% figure(2)
% clf
% pmap(nlon,slat,1e7*hp66_dtds);caxis([-1 1])
% 
% return


%dtdn
dd=griddata(nlon,slat',double(dtds_week),nlon,nlat');
dd(isnan(dd))=1e35;
dd=dd'; 
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)


fid = fopen('gaube_crh.txt', 'wt');

tt=[0 360 -80 80];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');
tt=[1440 640 .25 .25];
fprintf(fid, '%d ', tt);
fprintf(fid,'\n');

%hp dtdn
dd=griddata(nlon,slat',double(hp66_dtds),nlon,nlat');
dd(isnan(dd))=1e35;
dd=dd'; 
for m=1:nx
    fprintf(fid, '%e ', dd(m,:));
    fprintf(fid,'\n');
end
clear dd
fclose(fid)



