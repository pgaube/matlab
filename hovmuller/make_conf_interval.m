%first do vocals sections
set_hovs
startjd=2451395;
endjd=2454461;
%{
for m=[24 30 31]
	load(['/matlab/matlab/hovmuller/tracks/section_' num2str(m) '_tracks'])
	f1=find(track_jday>=startjd & track_jday<=endjd);
	id=id(f1);
	y=y(f1);
	icc=find(id>=nneg & y<0 | id<nneg & y>0);
	ic=find(id<nneg & y<0 | id>=nneg & y>0);
	eval(['k_',num2str(m),'_cc = length(unique(id(icc)));'])
	eval(['k_',num2str(m),'_c = length(unique(id(ic)));'])
end


load section_trans_samp 
std_24_c=section_24_bp26_chl_rot_N_c.std;
std_24_c(std_24_c>.06)=nan;
std_24_c=smoothn(fillnans(std_24_c),4);

std_24_cc=section_24_bp26_chl_rot_N_cc.std;
std_24_cc(std_24_cc>.06)=nan;
std_24_cc=smoothn(fillnans(std_24_cc),4);

std_30_c=section_30_bp26_chl_rot_N_c.std;
std_30_c(std_30_c>.06)=nan;
std_30_c=smoothn(fillnans(std_30_c),4);

std_30_cc=section_30_bp26_chl_rot_N_cc.std;
std_30_cc(std_30_cc>.06)=nan;
std_30_cc=smoothn(fillnans(std_30_cc),4);

std_31_c=section_31_bp26_chl_rot_N_c.std;
std_31_c(std_31_c>.06)=nan;
std_31_c=smoothn(fillnans(std_31_c),4);

std_31_cc=section_31_bp26_chl_rot_N_cc.std;
std_31_cc(std_31_cc>.06)=nan;
std_31_cc=smoothn(fillnans(std_31_cc),4);

ci_24_c=std_24_c.*tinv((.05)/2,k_24_c-1)./sqrt(k_24_c);
ci_24_cc=std_24_cc.*tinv((.05)/2,k_24_cc-1)./sqrt(k_24_cc);

figure(9)
clf
plot(section_24_bp26_chl_rot_N_c.mean(33,:),'b')
hold on
plot(section_24_bp26_chl_rot_N_cc.mean(33,:),'r')
plot(section_24_bp26_chl_rot_N_c.mean(33,:)-ci_24_c(33,:),'k--')
plot(section_24_bp26_chl_rot_N_c.mean(33,:)+ci_24_c(33,:),'k--')
plot(section_24_bp26_chl_rot_N_cc.mean(33,:)-ci_24_cc(33,:),'r--')
plot(section_24_bp26_chl_rot_N_cc.mean(33,:)+ci_24_cc(33,:),'r--')
title(['section 24, k_c = ',num2str(k_24_c),'  k_{cc} = ',num2str(k_24_cc),'  '])
print -dpng -r300 figs/ci/24_zonal

ci_30_c=std_30_c.*tinv((.05)/2,k_30_c-1)./sqrt(k_30_c);
ci_30_cc=std_30_cc.*tinv((.05)/2,k_30_cc-1)./sqrt(k_30_cc);
figure(10)
clf
plot(section_30_bp26_chl_rot_N_c.mean(33,:),'b')
hold on
plot(section_30_bp26_chl_rot_N_cc.mean(33,:),'r')
plot(section_30_bp26_chl_rot_N_c.mean(33,:)-ci_30_c(33,:),'k--')
plot(section_30_bp26_chl_rot_N_c.mean(33,:)+ci_30_c(33,:),'k--')
plot(section_30_bp26_chl_rot_N_cc.mean(33,:)-ci_30_cc(33,:),'r--')
plot(section_30_bp26_chl_rot_N_cc.mean(33,:)+ci_30_cc(33,:),'r--')
title(['section 30, k_c = ',num2str(k_30_c),'  k_{cc} = ',num2str(k_30_cc),'  '])
print -dpng -r300 figs/ci/30_zonal

ci_31_c=std_31_c.*tinv((.05)/2,k_31_c-1)./sqrt(k_31_c);
ci_31_cc=std_31_cc.*tinv((.05)/2,k_31_cc-1)./sqrt(k_31_cc);
figure(11)
clf
plot(section_31_bp26_chl_rot_N_c.mean(33,:),'b')
hold on
plot(section_31_bp26_chl_rot_N_cc.mean(33,:),'r')
plot(section_31_bp26_chl_rot_N_c.mean(33,:)-ci_31_c(33,:),'k--')
plot(section_31_bp26_chl_rot_N_c.mean(33,:)+ci_31_c(33,:),'k--')
plot(section_31_bp26_chl_rot_N_cc.mean(33,:)-ci_31_cc(33,:),'r--')
plot(section_31_bp26_chl_rot_N_cc.mean(33,:)+ci_31_cc(33,:),'r--')
title(['section 31, k_c = ',num2str(k_31_c),'  k_{cc} = ',num2str(k_31_cc),'  '])
print -dpng -r300 figs/ci/31_zonal


figure(5)
clf
subplot(321)
pcolor(double(std_24_c));shading flat
axis image
caxis([.03 .06])
colorbar
title('section 24 clockwise')
subplot(322)
pcolor(double(std_24_cc));shading flat
axis image
caxis([.03 .06])
colorbar
title('section 24 counter')
subplot(323)
pcolor(double(std_30_c));shading flat
axis image
caxis([.03 .06])
colorbar
title('section 30 clockwise')
subplot(324)
pcolor(double(std_30_cc));shading flat
axis image
colorbar
title('section 30 counter')
caxis([.03 .06])
subplot(325)
pcolor(double(std_31_c));shading flat
axis image
caxis([.03 .06])
colorbar
title('section 31 clockwise')
subplot(326)
pcolor(double(std_31_cc));shading flat
axis image
caxis([.03 .06])
colorbar
title('section 31 counter')
print -dpng -r300 figs/ci/sections_std


%now do midlat
load mgrad_combo_tracks
startjd=2451395;
endjd=2454461;

f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);
jd=unique(track_jday);
dir = nan(length(id),1);
for m=1:length(jd)
	load(['/matlab/matlab/global/ro_200_trans_samp/TRANS_W_ROT_',num2str(jd(m))],'rot_index','id_index')
	 ff=find(track_jday==jd(m));
	 day_id=unique(id(ff));
	 ii=sames(id(ff),id_index);
	 jj=sames(id_index,id(ff));
	 if any(ii)
	 	dir(ff(jj))=rot_index(ii);
	 end
	 m
end	 

%note 83=S, 78=N


icc=find(id>=nneg & y<0 | id<nneg & y>0);
ic=find(id<nneg & y<0 | id>=nneg & y>0);
icc_N=find(dir(icc)==78);
ic_N=find(dir(ic)==78);
icc_S=find(dir(icc)==83);
ic_S=find(dir(ic)==83);

k_midlat_N_cc = length(unique(id(icc_N)))
k_midlat_N_c = length(unique(id(ic_N)))

k_midlat_S_cc = length(unique(id(icc_S)))
k_midlat_S_c = length(unique(id(ic_S)))


load new_mgrad_rot_comps
std_midlat_N_c=rot_all_bp21_chl_N_c.std;
std_midlat_N_c=smoothn(fillnans(std_midlat_N_c),4);

std_midlat_N_cc=rot_all_bp21_chl_N_cc.std;
std_midlat_N_cc=smoothn(fillnans(std_midlat_N_cc),4);

std_midlat_S_c=rot_all_bp21_chl_S_c.std;
std_midlat_S_c(std_midlat_S_c>.07)=nan;
std_midlat_S_c=smoothn(fillnans(std_midlat_S_c),4);

std_midlat_S_cc=rot_all_bp21_chl_S_cc.std;
std_midlat_S_cc(std_midlat_S_cc>.07)=nan;
std_midlat_S_cc=smoothn(fillnans(std_midlat_S_cc),4);

figure(6)
clf
subplot(221)
pcolor(double(std_midlat_N_cc));shading flat
axis image
caxis([.03 .1])
colorbar
title('midlat northward counter')
subplot(222)
pcolor(double(std_midlat_N_c));shading flat
axis image
caxis([.03 .1])
colorbar
title('midlat northward clock')
subplot(223)
pcolor(double(std_midlat_S_cc));shading flat
axis image
caxis([.03 .06])
colorbar
title('midlat southward counter')
subplot(224)
pcolor(double(std_midlat_S_c));shading flat
axis image
caxis([.03 .06])
colorbar
title('midlat southward clock')
print -dpng -r300 figs/ci/midlat_std

ci_N_c=std_midlat_N_c.*tinv((.05)/2,k_midlat_N_c-1)./sqrt(k_midlat_N_c);
ci_N_cc=std_midlat_N_cc.*tinv((.05)/2,k_midlat_N_cc-1)./sqrt(k_midlat_N_cc);

ci_S_c=std_midlat_S_c.*tinv((.05)/2,k_midlat_S_c-1)./sqrt(k_midlat_S_c);
ci_S_cc=std_midlat_S_cc.*tinv((.05)/2,k_midlat_S_cc-1)./sqrt(k_midlat_S_cc);

figure(12)
clf
plot(rot_all_bp21_chl_N_c.mean(33,:),'k')
hold on
plot(rot_all_bp21_chl_N_cc.mean(33,:),'r')
plot(rot_all_bp21_chl_N_c.mean(33,:)-ci_N_c(33,:),'k--')
plot(rot_all_bp21_chl_N_c.mean(33,:)+ci_N_c(33,:),'k--')
plot(rot_all_bp21_chl_N_cc.mean(33,:)-ci_N_cc(33,:),'r--')
plot(rot_all_bp21_chl_N_cc.mean(33,:)+ci_N_cc(33,:),'r--')
title(['midlat northward, k_c = ',num2str(k_midlat_N_c),'  k_{cc} = ',num2str(k_midlat_N_cc),'  '])
print -dpng -r300 figs/ci/midlat_N_zonal

figure(13)
clf
plot(rot_all_bp21_chl_S_c.mean(33,:),'k')
hold on
plot(rot_all_bp21_chl_S_cc.mean(33,:),'r')
plot(rot_all_bp21_chl_S_c.mean(33,:)-ci_S_c(33,:),'k--')
plot(rot_all_bp21_chl_S_c.mean(33,:)+ci_S_c(33,:),'k--')
plot(rot_all_bp21_chl_S_cc.mean(33,:)-ci_S_cc(33,:),'r--')
plot(rot_all_bp21_chl_S_cc.mean(33,:)+ci_S_cc(33,:),'r--')
title(['midlat southward, k_c = ',num2str(k_midlat_S_c),'  k_{cc} = ',num2str(k_midlat_S_cc),'  '])
print -dpng -r300 figs/ci/midlat_S_zonal

%}
%now do model
load /matlab/matlab/QG_model/tracks/alpha_2_tau_30_tracks.mat
startjd=2;
endjd=15000;

f1=find(track_jdays>=startjd & track_jdays<=endjd);
id=id(f1);
y=y(f1);

ic=find(id>=nneg);
icc=find(id<nneg);
k_2_y_cc = length(unique(id(icc)))
k_2_y_c = length(unique(id(ic)))

clear id y
load /matlab/matlab/QG_model/tracks/alpha_1_tau_30_tracks.mat
startjd=2;
endjd=15000;

f1=find(track_jdays>=startjd & track_jdays<=endjd);
id=id(f1);
y=y(f1);

ic=find(id>=nneg);
icc=find(id<nneg);
k_1_y_cc = length(unique(id(icc)))
k_1_y_c = length(unique(id(ic)))

load /matlab/matlab/QG_model/alpha_1_tau_30_comps mean_* std_* xi yi

std_1_y_cc=std_y_c;
std_1_y_cc=smoothn(fillnans(std_1_y_cc),4);
std_1_y_c=std_y_a;
std_1_y_c=smoothn(fillnans(std_1_y_c),6);

figure(20)
clf
subplot(121)
pcolor(double(std_1_y_cc));shading flat
axis image
caxis([23 56])
colorbar
title('tracer counter')
subplot(122)
pcolor(double(std_1_y_c));shading flat
axis image
caxis([23 56])
colorbar
title('tracer clock')
print -dpng -r300 figs/ci/tracer_1_std


ci_1_y_c=std_1_y_c.*tinv((.05)/2,k_1_y_c-1)./sqrt(k_1_y_c);
ci_1_y_cc=std_1_y_cc.*tinv((.05)/2,k_1_y_cc-1)./sqrt(k_1_y_cc);


figure(21)
clf
plot(mean_y_a(41,:),'k')
hold on
plot(mean_y_c(41,:),'r')
plot(mean_y_a(41,:)+ci_1_y_c(41,:),'k--')
plot(mean_y_a(41,:)-ci_1_y_c(41,:),'k--')
plot(mean_y_c(41,:)+ci_1_y_cc(41,:),'r--')
plot(mean_y_c(41,:)-ci_1_y_cc(41,:),'r--')
title(['tracer, k_c = ',num2str(k_1_y_c),'  k_{cc} = ',num2str(k_1_y_cc),'  '])
print -dpng -r300 figs/ci/tracer_1_zonal

%
load /matlab/matlab/QG_model/tracks/alpha_3_tau_30_tracks.mat
startjd=3;
endjd=15000;

f1=find(track_jdays>=startjd & track_jdays<=endjd);
id=id(f1);
y=y(f1);

ic=find(id>=nneg);
icc=find(id<nneg);
k_3_y_cc = length(unique(id(icc)))
k_3_y_c = length(unique(id(ic)))

load /matlab/matlab/QG_model/alpha_3_tau_30_comps mean_* std_* xi yi

std_3_y_cc=std_y_c;
std_3_y_cc=smoothn(fillnans(std_3_y_cc),4);
std_3_y_c=std_y_a;
std_3_y_c=smoothn(fillnans(std_3_y_c),6);

figure(20)
clf
subplot(121)
pcolor(double(std_3_y_cc));shading flat
axis image

colorbar
title('tracer counter')
subplot(122)
pcolor(double(std_3_y_c));shading flat
axis image

colorbar
title('tracer clock')
print -dpng -r300 figs/ci/tracer_3_std


ci_3_y_c=std_3_y_c.*tinv((.05)/2,k_3_y_c-1)./sqrt(k_3_y_c);
ci_3_y_cc=std_3_y_cc.*tinv((.05)/2,k_3_y_cc-1)./sqrt(k_3_y_cc);


figure(21)
clf
plot(mean_y_a(41,:),'k')
hold on
plot(mean_y_c(41,:),'r')
plot(mean_y_a(41,:)+ci_3_y_c(41,:),'k--')
plot(mean_y_a(41,:)-ci_3_y_c(41,:),'k--')
plot(mean_y_c(41,:)+ci_3_y_cc(41,:),'r--')
plot(mean_y_c(41,:)-ci_3_y_cc(41,:),'r--')
title(['tracer, k_c = ',num2str(k_3_y_c),'  k_{cc} = ',num2str(k_3_y_cc),'  '])
print -dpng -r300 figs/ci/tracer_3_zonal


save -append conf_intervals ci_* std_* k_*




