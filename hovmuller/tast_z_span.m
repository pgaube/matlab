clear
close all

set_hovs
m=25;
hov_lon=[wlon(m) elon(m)];
hov_lat=lat(m);

	data_type='gchl_day'
	data_dir='/home/wallaby/data/pgaube/data/seawifs/mat/';
	data_head='SCHL_9_D_';
	jdays=[2450821:2454489];
	%data_type='gchl_day';
	%data_type='gpoc_day';
	load([data_dir data_head num2str(jdays(1))],'lat','lon');
	plon=biggrid(lon,9,25);
	glat=biggrid(lat,9,25);
	glon=cat(2,plon,360+plon(:,1:200));
	
	
	dist_n=abs(glat(:,1)-hov_lat+dy);
	dist_s=abs(glat(:,1)-hov_lat-dy);
	dist_w=abs(glon(1,:)-min(hov_lon));
	dist_e=abs(glon(1,:)-max(hov_lon));
	pdist_w=abs(glon(1,:)-(min(hov_lon)-10));
	pdist_e=abs(glon(1,:)-(max(hov_lon)+10));
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
	 dx_grid=.25;
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
	raw_hov=squeeze(nanmean(log10(pre_hov),1))';


dt=35;
%Correct time vectores if subset
%final_jdays=[2450821+round(dt/2):7:2454489-round(dt/2)];
%ij=find(final_jdays<=jdays(lj));
%just want AVISO jdays in range
final_jdays=[2450842:7:2454475];


%now interp to final hov grid
[hov,fl]=smooth2d_loess(raw_hov,plon,jdays,2,dt,final_lon,final_jdays);
%num_out_range=length(find(fl~=1))
%hov(fl~=1)=nan;
%hov=nan;

%remov zonal trans
for m=1:length(hov(:,1))
	lp=smooth1d_loess(hov(m,:),plon,6,plon);
	hov6(m,:)=hov(m,:)-lp;
	lp=smooth1d_loess(hov(m,:),plon,8,plon);
	hov8(m,:)=hov(m,:)-lp;
	lp=smooth1d_loess(hov(m,:),plon,10,plon);
	hov1(m,:)=hov(m,:)-lp;
	lp=smooth1d_loess(hov(m,:),plon,20,plon);
	hov2(m,:)=hov(m,:)-lp;
	
end
