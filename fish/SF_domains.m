set(0,'DefaultFigureVisible','on')
%close all
clear all
set_fish
clear mask bulk_temp
di=pwd;
load topo topomap1
minc=-3000;
maxc=3000;
sq = [ 
	52		47		-130		-122.5
	48		45		-129		-123
	46		41		-128		-123
	42		39		-128		-123
	40		33		-126		-115
	34.5	28.5	-121		-115
	33.5	26		-119		-111
	27		20		-116		-105	
	];
	
	
labs=['bc';'wa';'or';'nc';'cc';'sc';'nb';'sb'];	
	
%
lat=19:55;
lon=-135:-95;

%{
figure(1)
clf
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
for m=1:length(sq(:,1))
	m_line([sq(m,3) sq(m,4)],[sq(m,1) sq(m,1)],'color',[.5 .5 .5])
	m_line([sq(m,4) sq(m,4)],[sq(m,1) sq(m,2)],'color',[.5 .5 .5])
	m_line([sq(m,3) sq(m,4)],[sq(m,2) sq(m,2)],'color',[.5 .5 .5])
	m_line([sq(m,3) sq(m,3)],[sq(m,1) sq(m,2)],'color',[.5 .5 .5])
	m_text(sq(m,3)-5,sq(m,2)+(sq(m,1)-sq(m,2))/2,labs(m,:))
end
title('New Regions for SatFish.com   ')
print -dpng -r300 SF_regions
%}

for m=6%length(sq(:,1))
	region = labs(m,:)
	mlat=linspace(sq(m,2),sq(m,1),round((abs(sq(m,1)-sq(m,2)))*211.11));
	mlon=linspace(sq(m,3),sq(m,4),round((abs(sq(m,3)-sq(m,4)))*211.11));
	[mlon,mlat]=meshgrid(mlon,mlat);
	tt=flipud(mlat);
	save('-ascii',[labs(m,:),'_lat.txt'],'tt')
	tt=flipud(mlon);
	save('-ascii',[labs(m,:),'_lon.txt'],'tt')
	return
	%Topo
	%
	[tout,lonout,latout]=get_topo([sq(m,3):sq(m,4)],[sq(m,2):sq(m,1)]);
	
	topo=griddata(-180-(180-lonout),latout,tout,mlon,mlat,'cubic');
	
	%now make land mask for data proccessing
	figure(2)
	clf
	set(gcf, 'InvertHardCopy', 'off');
	m_proj('Miller Cylindrical','lon',[min(mlon(:)) max(mlon(:))],'lat',[min(mlat(:)) max(mlat(:))]);
	m_gshhs_f('save','gumby');
	m_pcolor(mlon,mlat,nan*mlat);
	shading flat
	m_usercoast('gumby','patch','k');
	m_usercoast('gumby','color','k');
	axis image
	set(gca,'xtick',[],'ytick',[])
	eval(['print -dpng -r300 ', '~/fish/land_masks/',labs(m,:),'_load_mask.png'])
	eval(['crop(',char(39),'~/fish/land_masks/',labs(m,:),'_load_mask.png',char(39),')'])
	fl=input('edit mask')
	eval(['mask=flipud(nanmean(imread(',char(39),'~/fish/land_masks/',labs(m,:),'_load_mask.png',char(39),'),3));'])
	mask(mask==255)=1;
	mask(mask==0)=nan;
	
	%{
	rb=(sum(isnan(mask),2));
	cb=(sum(isnan(mask),1));
	mask(rb>=.9*length(mask(:,1)),:)=[];
	mask(:,cb>=.9*length(mask(1,:)))=[];
	%}
	
	mask(:,1:2)=[];
	mask(1:2,:)=[];
	mask(:,end-2:end)=[];
	mask(end-2:end,:)=[];
	mask=imresize(mask,[length(mlat(:,1)) length(mlat(1,:))]);
	mask(~isnan(mask))=1;
	imask=nan*mask;
	imask(isnan(mask))=1;
	save([labs(m,:),'_sf_mask'],'mlat','mlon','mask','imask','topo')
	
	pgray=gray(256);
	irgb = flipud(imask);
	irgb(isnan(irgb))=256;
	q=ones(256,1);
	q(256)=0;     
    imwrite(irgb,pgray,['~/fish/land_masks/',labs(m,:),'_mask.png'],'Transparency',q)	

	ftopo=0.547*topo;
	idata=flipud(topo);
	new_mask=nan*idata;
	new_mask(~isnan(idata))=1;
	nrgb=length(topomap1(:,1));
	
	minc=-3500;
	maxc=2750;
	cstep = (nrgb-1)/(maxc-minc);
	irgb = max(min(round((idata-minc)*cstep+1),nrgb),1).*flipud(imask);
	imwrite(irgb,topomap1,['~/fish/land_masks/',labs(m,:),'_topo.png']);
	
	minc=-3500;
	maxc=2750;
	irgb = max(min(round((idata-minc)*cstep+1),nrgb),1).*flipud(mask);
	imwrite(irgb,topomap1,['~/fish/land_masks/',labs(m,:),'_bath.png']);
	
	figure(3)
	clf
	set(gcf, 'InvertHardCopy', 'off');
	m_proj('Miller Cylindrical','lon',[min(mlon(:)) max(mlon(:))],'lat',[min(mlat(:)) max(mlat(:))]);
	m_pcolor(mlon,mlat,nan*mlat);
	shading flat
	%m_usercoast('gumby','patch','k');
	%m_usercoast('gumby','color','k');
	axis image
	set(gca,'xtick',[],'ytick',[])
	hold on
	m_contour(mlon,mlat,ftopo,[-250 -250],'color',[55/255 255/255 255/255])
	m_contour(mlon,mlat,ftopo,[-500 -500],'color',[51/255 153/255 255/255])
	m_contour(mlon,mlat,ftopo,[-750 -750],'color',[51/255 102/255 255/255])
	m_contour(mlon,mlat,ftopo,[-1000 -1000],'color',[51/255 51/255 204/255])
	m_contour(mlon,mlat,ftopo,[-1500 -1500],'color',[0/255 0/255 170/255])
	m_contour(mlon,mlat,ftopo,[-2000 -2000],'color',[0/255 0/255 119/255])
	eval(['print -dpng -r300 ', '~/fish/land_masks/',labs(m,:),'_cont.png'])
	eval(['crop(',char(39),'~/fish/land_masks/',labs(m,:),'_cont.png',char(39),')'])
	conts=imread(['~/fish/land_masks/',labs(m,:),'_cont.png']);
	%{
	conts(:,1:2)=[];
	conts(1:2,:)=[];
	conts(:,end-2:end)=[];
	conts(end-2:end,:)=[];
	%}
	mconts=imresize(conts, [length(mlat(:,1)) length(mlat(1,:))]);
	imwrite(mconts,['~/fish/land_masks/',labs(m,:),'_cont.png']);
end	