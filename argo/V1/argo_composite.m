%
clear all
load /matlab/matlab/argo/argo_prof_index.mat pfile pjday plat plon

%{
[s_pjday,s_i]=sort(pjday);
pfile=pfile(s_i);
plat=plat(s_i);
plon=plon(s_i);
%}

loadpath='/matlab/data/eddy/V4/mat/';
head='AVISO_25_W_';

startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454804;
jdays=startjd:7:endjd;

load([loadpath,head,num2str(jdays(10))],'lon','lat')
mask=nan(length(lat(:,1)),length(lon(1,:)),length(jdays));

%make mask matrix
%{
for m=1:length(jdays)
	load([loadpath,head,num2str(jdays(10))],'a_mask','c_mask')
	mask(:,:,m)=nanmean(cat(3,a_mask,c_mask),3);
	m
end	

save eddy_mask mask
%}
load eddy_mask
tt=find(pjday>=startjd-3 & pjday<=endjd);
pfile=pfile(tt);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);


%load /Volumes/matlab/data/eddy/V3/eid_mask_matrix
load /matlab/data/eddy/V4/dCCNS_lat_lon_tracks

%
pp=1;
%now go through each float and find out if it is in an eddy
%

[eddy_id,eddy_scale,eddy_plon,eddy_plat,eddy_x,eddy_y]=deal(nan(length(id),1));
[eddy_t,eddy_s,eddy_p,eddy_st]=deal(nan(length(id),600));

lap=length(pjday);

ppres=[0:10:1000]';

eddy_ist=nan(length(id),length(ppres));


total_number_of_float=lap
n=1;

lap=length(pjday);
%progressbar('Checking Float')
for m=n:lap
	fprintf('\r checking float %6u or %6u found %6u good profiles \r',m,lap,pp)
	%progressbar(m/lap)
	%interp profile location to 1/4 degree grid
	tx=plon(m);
	ty=plat(m);
	tmp=num2str(pfile{m});
	jj=find(tmp=='/');
	tmpp=tmp(jj(3)+1:length(tmp));
	if strcmp(tmpp(1),'D')
	if ~isnan(tx)
	if ~isnan(ty)
		% interp tx and ty to 1/4 degree grid using min dist
    	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
    	tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    	disx = abs(tmpxs-tx);
    	disy = abs(tmpys-ty);
    	iminx=find(disx==min(disx));
    	iminy=find(disy==min(disy));
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(lat(:,1)==cy);
    	c=find(lon(1,:)==cx);
    
    	if any(r)
    	if any(c)
    		%interp pjday to closest week
    		tj=round(pjday(m));
    		tmpj=tj-3:tj+3;
    		p=sames(tmpj,jdays);
    	
    		if any(p)
    			%now look to see if float is in eddy
    			if ~isnan(mask(r,c,p))
				tmp=num2str(pfile{m});
				ff=find(tmp=='/');
				fname=tmp(ff(3)+1:length(tmp));
				if exist(['/data/argo/profiles/', fname])
					[blank,dumb,pres,s,t]=read_profiles(fname);
					tt=sw_dens(s',sw_ptmp(s',t',pres',0),0)-1000;
					if min(pres)<10 & min(tt)>15 & max(tt)<100
					   t=filter_sigma(3,t);
					   s=filter_sigma(3,s);	
					   fr=find(pres>9999);
					   if any(fr)
							pres(fr)=[];
							t(fr)=[];
							s(fr)=[];
							tt(fr)=[];
					   end	
					   eddy_t(pp,1:length(t))=t';
					   eddy_s(pp,1:length(t))=s';
					   eddy_st(pp,1:length(t))=tt;
					   eddy_p(pp,1:length(t))=pres';
					   eddy_ist(pp,1:length(ppres))=interp1(pres',tt,ppres,'linear');
					end   
				end
			
				eddy_plat(pp)=plat(m);
				eddy_plon(pp)=plon(m);
				eddy_id(pp)=id(ii);
				eddy_x(pp)=x(ii);
				eddy_y(pp)=y(ii);
				eddy_scale(pp)=efold(ii); 				
				pp=pp+1;
				end
    		end
    	end
    	end
    end
    end
    end
    n=n+1;
end
fprintf('\n')

save CCNS_eddy_argo_prof.mat eddy_*

%}    
load LW_eddy_argo_prof.mat
load /matlab/data/eddy/V4/EIO_lat_lon_tracks nneg

te=nansum(eddy_p,1);
ii=find(te==0);
eddy_x(ii)=[];
eddy_y(ii)=[];
eddy_plon(ii)=[];
eddy_plat(ii)=[];
eddy_scale(ii)=[];
eddy_st(ii,:)=[];
eddy_p(ii,:)=[];

dist_x=(111.11*cosd(eddy_y).*(eddy_plon-eddy_x))./eddy_scale;
dist_y=(111.11*(eddy_plat-eddy_y))./eddy_scale;
dist=sqrt(dist_x.^2+dist_y.^2);
sig_dist=dist;
sig_dist(dist_x<0)=-sig_dist(dist_x<0);

psig_dist=sig_dist';
eddy_st=eddy_st';
eddy_p=eddy_p';
sig_dist=ones(length(eddy_p(:,1)),1)*psig_dist;
isig_dist=ones(length(eddy_p(:,1)),1)*psig_dist;

isig_dist=ones(length(ppres(:,1)),1)*psig_dist;
xi=[-2:.125:2];
pres=ppres*ones(1,length(xi));
ipres=ppres*ones(1,length(isig_dist(1,:)));
xi=ones(length(pres(:,1)),1)*xi;


eddy_p(isnan(eddy_p))=0;



%{
interp_eddy_p=griddata(sig_dist,eddy_p,eddy_p,isig_dist,ipres);
interp_eddy_st=griddata(sig_dist,eddy_p,eddy_st,isig_dist,ipres);
%}
ii=find(eddy_id>=nneg);
ac_sigma=griddata(sig_dist(:,ii),eddy_p(:,ii),eddy_st(:,ii),xi,pres);
sm_ac_sigma=smoothn(ac_sigma,20);

lp_ac=linx_smooth2d_f(sm_ac_sigma,150,1);
hp_ac=sm_ac_sigma-lp_ac;

ii=find(eddy_id<nneg);
cc_sigma=griddata(sig_dist(:,ii),eddy_p(:,ii),eddy_st(:,ii),xi,pres);
cc_sigma(cc_sigma>33)=nan;
sm_cc_sigma=smoothn(cc_sigma,20);

lp_cc=linx_smooth2d_f(sm_cc_sigma,150,1);
hp_cc=sm_cc_sigma-lp_cc;

%{
tt=interp_eddy_p;
tt(find(isnan(tt)))=0;
interp_ac_sigma=griddata(isig_dist(:,ii),tt(:,ii),interp_eddy_st(:,ii),xi,pres);
loess_ac_sigma=smooth2d_loess(interp_eddy_st(:,ii),isig_dist(ii),interp_eddy_p(:,1),.5,30,xi(1,:),pres(:,1));
%}


save CCNS_test_vert *ac* *cc* pres xi
