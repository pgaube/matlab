function [hp_hov,thp_hov,full_hov,raw_hov,plon,final_lon,year_day,final_jdays]=hovmoller_loess(hov_lon,hov_lat,dy,data_type)
%function [hp_hov,full_hov,raw_hov,plon,final_lon,year_day,final_jdays]=hovmoller_loess(hov_lon,hov_lat,dy,data_type)

dt=20;
dx=2.5;
dx2=6;
dx_grid=.25;


	switch data_type
	case {'gchl_day','lp22_chl'}
	data_dir='/home/wallaby/data/pgaube/data/seawifs/mat/';
	data_head='SCHL_9_D_';
	jdays=[2450821:2454489];
	%data_type='gchl_day';
	%data_type='gpoc_day';
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	plon=biggrid(lon,9,25);
	glat=biggrid(lat,9,25);
	glon=cat(2,plon,360+plon(:,1:200));
	case {'gsm_day'}
	data_dir='/Volumes/matlab/data/gsm/mat/';
	data_head='GSM_9_D_';
	jdays=[2450821:2454489];
	%data_type='gchl_day';
	data_type='gcar_day';
	loN=[0:8640]/24;
	LON=loN(2:2:8640);
	laT=[2160:-1:-2160]/24;
	LAT=laT(2:2:4320); 
	lat=single(LAT);
	lon=single(LON);
	[lon,lat]=meshgrid(lon,lat);
	plon=biggrid(lon,9,25);
	glat=biggrid(lat,9,25);
	glon=cat(2,plon,360+plon(:,1:200));
	case {'ssh'}
	data_dir='/Volumes/matlab/data/eddy/V4/mat/';
	data_head='AVISO_25_W_';
	startyear = 1992;
	startmonth = 10;
	startday = 14;
	endyear = 2008;
	endmonth = 01;
	endday = 23;
	startjd=date2jd(startyear,startmonth,startday)+.5;
	endjd=date2jd(endyear,endmonth,endday)+.5;
	jdays=[startjd:7:endjd];
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	glat=lat;
	glon=cat(2,lon,360+lon(:,1:200));
	end
	
	dist_n=abs(glat(:,1)-hov_lat+dy);
	dist_s=abs(glat(:,1)-hov_lat-dy);
	dist_w=abs(glon(1,:)-min(hov_lon));
	dist_e=abs(glon(1,:)-max(hov_lon));
	pdist_w=abs(glon(1,:)-(min(hov_lon)-dx2));
	pdist_e=abs(glon(1,:)-(max(hov_lon)+dx2));
	mn=find(dist_n==min(dist_n));
	ms=find(dist_s==min(dist_s));
	r=ms(1):mn(1);
	if length(r)<1
		r=mn(1):ms(1);
	end	
	c=find(dist_w==min(dist_w)):find(dist_e==min(dist_e));
	pc=find(pdist_w==min(pdist_w)):find(pdist_e==min(pdist_e));
	plon=glon(1,pc);
	
	%make final long, from Schlax
	 nx=0;
	 nx_grid=length(glon(1,:));
   	 for i=1:nx_grid
         rlon=0.+(i-1)*dx_grid+dx_grid/2;
         if rlon >= min(hov_lon) & rlon <= max(hov_lon)
        	nx=nx+1;
        	final_lon(nx)=rlon; 
      	end
  	 end
  	 ddr=find(glat(:,1)>=-80 & glat(:,1)<=80);
  	 plat=flipud(glat(ddr,1));
  	 ilon=find(plon(1,:)==final_lon(1));
  	 ilon=ilon-1;%make it FORTRAN index
  	 ilat=find(plat==hov_lat-.125);
  	 ilat=ilat-1;
	 prefilt_lon=[min(final_lon)-dx2/2:dx_grid:max(final_lon)+dx2/2];

%create array
pre_hov=nan(length(r),length(pc),length(jdays));

%now sample all files
lj=length(jdays);
for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	if exist([data_dir data_head num2str(jdays(m)) '.mat'])
		load([data_dir data_head num2str(jdays(m))],data_type);
		eval([data_type '= cat(2,' data_type ',' data_type '(:,1:200));'])
		eval(['pre_hov(:,:,m)=' data_type '(r,pc);'])
	end	
end
fprintf('\n')

%calc lat mean
switch data_type
case {'gcar_day','gchl_day','lp22_chl'}
	raw_hov=squeeze(nanmean(log10(pre_hov),1))';
case {'ssh'}
	raw_hov=squeeze(nanmean(pre_hov,1))';
end



%Correct time vectores if subset
%final_jdays=[2450821+round(dt/2):7:2454489-round(dt/2)];
%ij=find(final_jdays<=jdays(lj));
%just want AVISO jdays in range
final_jdays=[2450842:7:2454475];

%now interp to final hov grid
fprintf('\r    interpolating to final grid\r')
[hov,fl]=smooth2d_loess(raw_hov,plon,jdays,dx,dt,prefilt_lon,final_jdays);
%num_out_range=length(find(fl~=1))
%hov(fl~=1)=nan;
%hov=nan;

full_hov=hov;

jdays=final_jdays;

%make year_day vector
[year,mon,day]=jd2jdate(jdays);
for m=1:length(jdays)
	year_day(m)=(year(m)*1000)+julian(mon(m),day(m),year(m),year(m));
end	

hp_hov=hov;


%remov zonal trans
fprintf('\n    removing zonal trend\r')
for m=1:length(hov(:,1))
	lp=smooth1d_loess(hp_hov(m,:),prefilt_lon,20,prefilt_lon);
	hp_hov(m,:)=hp_hov(m,:)-lp;
end

%truncate to final section
ig=sames(final_lon,prefilt_lon);
full_hov=full_hov(:,ig);
hp_hov=hp_hov(:,ig);

%remove SS
fprintf('\n    removing time trend\r')
for n=1:length(hp_hov(1,:))
	ny = smooth1d_loess(squeeze(hp_hov(:,n)),jdays',250,jdays');
	thp_hov(:,n)=hp_hov(:,n)-ny;
end	


fprintf('\n')


