%loads SeaWiFS CHL data
clear all
close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);


osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
load([osave_path osave_head num2str(jdays(1))],'sst_week','lat','lon')

%
dx=single(nan(720,1440,lj));
dy=dx;
dradt=dx;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([osave_path osave_head num2str(jdays(m))],'sst_week','lat','lon')
	dtdx=dfdx(lat,sst_week,.25);
	dtdy=dfdy(sst_week,.25);
	
	dx(:,:,m)=dtdx;
	dy(:,:,m)=dtdy;
	gradt(:,:,m)=sqrt(dtdx.^2+dtdy.^2);
end
%}
%save gradt_steady dx dy dradt

mean_gradt=nanmean(gradt,3);
mean_dtdx=nanmean(dx,3);
mean_dtdy=nanmean(dy,3);

rat=nanmean(abs(dy)./abs(dx),3);

sm_rat=smoothn(rat,30);
save gradt_steady sm_rat lat lon mean_*
%save -v7.3 gradt_steady dx dy jdays lat lon rat

