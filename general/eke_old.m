global M
global N

N=4
M=4

%Set range of dates
startyear = 1992;
startmonth = 10;
startday = 14;
endyear = 2008;
endmonth = 01;
endday = 23;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
mid_week_jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(mid_week_jdays);
for m=1:length(mid_week_jdays)
	yearday(m)=year(m)*1000+julian(month(m),day(m),year(m));
	dates(m)=(year(m)*10000)+(month(m)*100)+day(m);
end



load_path = '/Volumes/matlab/data/eddy/V3/ssh/'
[ssh,lon,lat]=read_ssh([load_path,'aviso_20080102.20x10_hp']);
lat=lat'*ones(1,length(lon));
lon=ones(length(lat(:,1)),1)*lon;

split_domain
rs=1:length(r1);
cs=1:length(c1);

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    subset_ssh=nan(length(r),length(c),length(mid_week_jdays));
    for m=1:length(mid_week_jdays)
        fname = [load_path 'aviso_' num2str(dates(m)) '.20x10_hp'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        [ssh]=read_ssh(fname);
        subset_ssh(rs,cs,m)=single(ssh(r,c));
    end
    for m=1:length(subset_ssh(1,1,:))
    [u(:,:,m),v(:,:,m)]=geostro(lon(r,c),lat(r,c),subset_ssh(:,:,m)./10);
    end
    eke_map(r,c)=nanmean((u.^2+v.^2)/2,3);
        

end
