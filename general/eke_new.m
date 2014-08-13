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



load_path = '/Volumes/matlab/data/eddy/V3/mat/'
load([load_path,'AVISO_25_W_2448910.mat']);


split_domain
rs=1:length(r1);
cs=1:length(c1);

for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    subset_u=nan(length(r),length(c),length(mid_week_jdays));
    subset_v=nan(length(r),length(c),length(mid_week_jdays));
    for m=1:length(mid_week_jdays)
        fname = [load_path 'AVISO_25_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname,'u','v')
        subset_u(:,:,m)=single(u(r,c));
        subset_v(:,:,m)=single(v(r,c));
    end
    eke_map(r,c)=nanmean((subset_u.^2+subset_v.^2)/2,3); 

end
