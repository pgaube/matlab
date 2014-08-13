a=-0.3467;
b=3.3220;
%{
load /matlab/matlab/domains/EK_lat_lon
load /matlab/matlab/argo/eddy_UCSD_mld_index

ii=find(eddy_plon>=min(lon(:)) & eddy_plon<=max(lon(:)) & eddy_plat>=min(lat(:)) & eddy_plat<=max(lat(:)));

%ii=1:length(plat);
cc=nan(length(ii),1);
par=nan(length(ii),1);
ig=nan(length(ii),1);
id=ig;
progressbar('Checking Float')
lap=length(ii);
	
for m=1:length(ii)
	progressbar(m/lap)
	if(~isnan((eddy_pjday_round(ii(m))))) & exist(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m))),'.mat'])
	load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(m)))],'gpar_week','gchl_week','gcar_week','glat','glon')
	tx=eddy_plon(ii(m));
	ty=eddy_plat(ii(m));
	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
    tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    [r,c]=imap(cy-.1,cy+.1,cx-.1,cx+.1,glat,glon);	
    if r>2 & r<=length(glon(:,1))-2 & c>2 & c<=length(glon(1,:))-2
    tmp_chl=10.^gchl_week(r-2:r+2,c-2:c+2);
    tmp_car=10.^gcar_week(r-2:r+2,c-2:c+2);
    cc(m)=nanmean(tmp_chl(:))/nanmean(tmp_car(:));
    par(m)=gpar_week(r,c);
    z1=exp(a*log(nanmean(tmp_chl(:)))+b);
    kd1=log(.01)./z1;
	ig(m) = gpar_week(r,c).* exp(-kd1.*(eddy_mld(ii(m))./2));
	id(m) = eddy_id(ii(m));
    end
    end
end

save indian_test_photac ig id cc par 

return
%}
%the global curve
sum_par=2;
win_par=1;
mld=50;
chl=0:.05:10;
a=-0.3467;
b=3.3220;
	
z=exp(a*log(chl)+b);
kd=log(.01)./z;
	
%Calculate Ig and CC_light
ig = 0:.05:2.5;

cc = .022+(.045-.022)*exp(-3*ig);

mld1=30;
chl1=.01;
z1=exp(a*log(chl1)+b);
kd1=1./z1;
ig1 = sum_par.* exp(-kd1.*(mld1./2));
cc1 = .022+(.045-.022)*exp(-3*ig1)

mld2=70;
chl2=.1;
z2=exp(a*log(chl2)+b);;
kd2=1./z2;;
ig2 = win_par.* exp(-kd2.*(mld2./2));
cc2 = .022+(.045-.022)*exp(-3*ig2)

mld2=150;
chl2=.1;
z2=exp(a*log(chl2)+b);;
kd2=1./z2;;
ig3 = win_par.* exp(-kd2.*(mld2./2));
cc3 = .022+(.045-.022)*exp(-3*ig3)

figure(6)
clf
plot(ig,cc,'k')
ylabel('CHL:C')
xlabel('I_g')
hold on
plot(ig1,cc1,'r*')
plot(ig2,cc2,'b*')
plot(ig3,cc3,'g*')
title('CHL:C as a function of I_g')
legend('CHL:C resultant from light alone','summer (40m and .01 mg m^{-3})',...
'winter (70m and .1 mg m^{-3})','ARGO 90th percentile (150m and .1 mg m^{-3})')
axis([0 2 .01 .05])
return
print -dpng -r300 figs/chl_c_winter_summer

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/

save -ascii calcom_data/ig.txt ig
save -ascii calcom_data/cc.txt cc
nyp=length(ig)
cd /matlab/matlab/eddy-wind/
