clear all
mon_str={'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'};
data_in='qscat.u'

path_in='/home/wallaby/data/pgaube/data/qscat/daily/oct12_exp22_qscat_'
%Set range of dates

load /home/wallaby/data/pgaube/data/qscat/daily/oct12_exp22_qscat_aug2000-output.mat
lat=qscat.lat;
lon=qscat.lon;
[lon,lat]=meshgrid(lon,lat);
startjd=date2jd(1999,7,19)+.5;
endjd=date2jd(2009,11,19)+.5;

jdays=[startjd:endjd];

%%%%%OVERRIDE TO SHORTEN DATASET
jdays=jdays(100:2000);
% u=single(nan(length(lat(:,1)),length(lon(1,:)),length(jdays)));
% v=u;
[year,month,day]=jd2jdate(jdays);
load_path = path_in;
cname='t';
rr=1;
uyear=unique(year);
for m=1:length(uyear)
    for n=1:12
        if rr<2001
            fname = [load_path mon_str{n} num2str(uyear(m)) '-output.mat'];
            display(['loading file ',fname])
            tesst=strcmp(fname,cname);
            if tesst~=1
                if exist(fname)
                    load(fname)
                    [dud,dud,ddd]=datevec(qscat.datenum);
                    for dd=1:length(ddd)
                        tt=qscat.u(:,:,dd);
                        u(:,:,rr)=tt;
                        tt=qscat.v(:,:,dd);
                        v(:,:,rr)=tt;
                        rr=rr+1;
                    end
                end
            end
        end
    end
end


u_bar=nanmean(u,3);
v_bar=nanmean(v,3);
mean_speed=sqrt(u_bar.^2+v_bar.^2);

mask=nan*u_bar;
ii=find(mean_speed<=10);
mask(ii)=1;

dir_steady = sqrt(nanmean(u,3).^2+nanmean(v,3).^2)./nanmean(sqrt(u.^2+v.^2),3);

save /matlab/data/QuickScat/mean_qscat u_bar v_bar dir_steady mean_speed mask
