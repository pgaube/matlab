clear all
close all

%
head   = 'AVISO_25_W_';
loadpath   = '~/data/eddy/V5/mat/';
eddy_file = '~/data/eddy/V5/global_tracks_V5_12_weeks'
load(eddy_file)
startjd=min(track_jday); 
endjd=max(track_jday);
jdays=startjd:7:endjd;

ext_x=nan*x;
ext_y=nan*x;
eddy_ssh=nan*x;


for m=1:length(jdays)
    [ye,mo,da]=jd2jdate(jdays(m));
    display([num2str(ye) '-' num2str(mo) '-' num2str(da)])
    kk=find(track_jday==jdays(m));
    load([loadpath,head,num2str(jdays(m))],'idmask','ssh','lon','lat')
	for m=1:length(kk)
        [r,c]=imap(y(kk(m))-.125,y(kk(m))+.125,x(kk(m))-.125,x(kk(m))+.125,lat,lon);
        r=r(1);
        c=c(1);
        mask=nan*idmask;
        mask(abs(idmask)==eid(kk(m)))=1;
        tmp_ssh=ssh.*mask;
        ii=find(abs(tmp_ssh)==max(abs(tmp_ssh(:))));
        if any(ii)
            eddy_ssh(kk(m))=tmp_ssh(ii(1));
        end
        imax=find(abs(tmp_ssh)==abs(eddy_ssh(kk(m))));
        if length(imax)==1
            ext_x(kk(m))=lon(imax);
            ext_y(kk(m))=lat(imax);
        end 
        
%         dif_x=x(kk(m))-ext_x(kk(m))
%         dif_y=y(kk(m))-ext_y(kk(m))
    end
end

eval(['save -append ', eddy_file, ' ext_x ext_y eddy_ssh'])