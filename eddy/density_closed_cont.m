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

load_path = '/Volumes/matlab/data/eddy/V4/mat/'
load([load_path,'AVISO_25_W_2454328.mat'])

density=nan.*mask;
density_trapped=density;
ttmp=density;

for m=1:length(mid_week_jdays)
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    load([load_path,'AVISO_25_W_',num2str(mid_week_jdays(m))],'idmask')
    mask=~isnan(idmask);
    ttmp=ttmp.*nan;
    ttmp(idmask<0)=1;
    ttmp(idmask<0)=1;
    density=nansum(cat(3,density,mask),3);
    density_trapped=nansum(cat(3,density_trapped,ttmp),3);
end
