function [hp_hov,thp_hov,full_hov,final_lon,year_day,jdays]=hovmoller(hov_lon,hov_lat,data_type)
%function [hp_hov,thp_hov,full_hov,final_lon,year_day,jdays]=hovmoller(hov_lon,hov_lat,data_type)


dt=30;
dx=2;
dx2=20;
dx_grid=.25;


	switch data_type
	case {'gsm_chl'}
	data_dir='~/data/gsm/mat/';
	data_head='GSM_9_21_';
	jdays=[2450849:7:2454489];
	data_type='sm_gchl_week';
	load([data_dir data_head num2str(jdays(1))],'glat','glon');
	plon=glon;
	glon=cat(2,plon,360+plon(:,1:200));
	case {'sst'}
	data_dir='~/data/ReynoldsSST/mat/';
	data_head='OI_25_30_';
	jdays=[2452459:7:2454489];
	data_type='sst_week';
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	plon=lon;
	glat=lat;
	glon=cat(2,plon,360+plon(:,1:200));
	case {'ssh'}
	data_dir='~/data/eddy/V5/mat/';
	data_head='AVISO_25_W_';
	jdays=[2450849:7:2454489];
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	glat=lat;
	plon=lon;
	glon=cat(2,lon,360+lon(:,1:200));
	case {'bp26_crlg'}
	data_dir='/matlab/data/eddy/V4/mat/';
	data_head='AVISO_25_W_';
	jdays=[2450849:7:2454489];
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	glat=lat;
	plon=lon;
	glon=cat(2,lon,360+lon(:,1:200));
	case {'na_crlg'}
	data_dir='/matlab/data/rand/';
	data_head='RAND_W_';
	jdays=[2450849:7:2454489];
	load(['/matlab/data/eddy/V4/mat/AVISO_25_W_' num2str(jdays(1))],'lat','lon');
	glat=lat;
	plon=lon;
	glon=cat(2,lon,360+lon(:,1:200));
	case {'bp26_crl'}
	data_dir='/matlab/data/QuickScat/mat/';
	data_head='QSCAT_30_25km_';
	jdays=[2452459:7:2454489];
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	glat=lat;
	plon=lon;
	glon=cat(2,lon,360+lon(:,1:200));
	end
	
	
	dist_ns=abs(glat(:,1)-hov_lat);
	dist_w=abs(glon(1,:)-min(hov_lon));
	dist_e=abs(glon(1,:)-max(hov_lon));
	pdist_w=abs(glon(1,:)-(min(hov_lon)-dx2));
	pdist_e=abs(glon(1,:)-(max(hov_lon)+dx2));
	r=find(dist_ns==min(dist_ns));
	if length(r)>1;
		r=r(1);
	end	
	c=find(dist_w==min(dist_w)):find(dist_e==min(dist_e));
	pc=find(pdist_w==min(pdist_w)):find(pdist_e==min(pdist_e));
	plon=glon(1,pc)
	
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
	else
	fprintf('\n    missing data file %03u',m)
	end	
end

hov=squeeze(pre_hov)';



full_hov=hov;
hp_hov=hov;
thp_hov=hov;

%make year_day vector
[year,mon,day]=jd2jdate(jdays);
for m=1:length(jdays)
	year_day(m)=(year(m)*1000)+julian(mon(m),day(m),year(m),year(m));
end	

hp_hov=hov;


%remov zonal trans
%{
fprintf('\n    removing zonal trend\r')
for m=1:length(hov(:,1))
	lp=smooth1d_loess(hp_hov(m,:),plon,dx2,plon);
	hp_hov(m,:)=hp_hov(m,:)-lp;
end

%truncate to final section
[blan,ig]=imap(1,1,min(final_lon),max(final_lon),glat,plon);
full_hov=full_hov(:,ig);
hp_hov=hp_hov(:,ig);

thp_hov=hp_hov;
%remove time trend
fprintf('\n    removing time trend\r')
for n=1:length(hp_hov(1,:))
	ny = smooth1d_loess(squeeze(hp_hov(:,n)),jdays',250,jdays');
	thp_hov(:,n)=hp_hov(:,n)-ny;
end	
%}

fprintf('\n')


