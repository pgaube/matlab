%{
clear all

var1='bp26_sst'
var2='bp26_wspd'



SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';
OI_HEAD   = 'OI_25_30_';
OI_PATH   = '/matlab/data/ReynoldsSST/mat/';
Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';


startjd=2452459;
endjd=2454489;
jdays=startjd:7:endjd;

load([SSH_PATH SSH_HEAD num2str(jdays(1))],'lon','lat')
lat=lat(41:600,:);
lon=lon(41:600,:);

[r,c]=imap(-45,-15,0,360,lat,lon);
mask2=nan(size(lat));
mask2(r,c)=1;
[r,c]=imap(15,45,0,360,lat,lon);
mask2(r,c)=1;
% initalize
[tmp_var1]=single(nan(length(lat(:,1)),length(lon(1,:)),length(jdays)));
tmp_var2=tmp_var1;


for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
	load([SSH_PATH SSH_HEAD num2str(jdays(m))],'mask')
	load([Q_PATH Q_HEAD num2str(jdays(m))],'bp26_wspd')
	load([OI_PATH OI_HEAD num2str(jdays(m))],'bp26_sst')
   	mask=mask(41:600,:);
   	bp26_sst=bp26_sst(81:640,:).*mask.*mask2;
   	bp26_wspd=bp26_wspd.*mask.*mask2;
   	tmp_var1(:,:,m)=bp26_sst;
   	tmp_var2(:,:,m)=bp26_wspd;
   
end     

save coupco_sst_wspd tmp_var1 tmp_var2
fprintf('\n')


load coupco_sst_wspd tmp_var1 tmp_var2
x=tmp_var1(:);
y=tmp_var2(:);
ibad=find(isnan(x));
x(ibad)=[];
y(ibad)=[];
ibad=find(isnan(y));
x(ibad)=[];
y(ibad)=[];

save coupco_sst_wspd x y
%}
load coupco_sst_wspd x y

step=.01;
min_x=-1;
max_x=1;
min_y=-1;
max_y=1;


fprintf('\n     bin averaging\r')
tbins1=[-1:.05:1];
for i=1:length(tbins1)-1
    bin_est = find(x>=tbins1(i) & x<tbins1(i+1));
    binned_samps11(i) = double(pmean(x(bin_est)));
    std_samps11(i) = double(pstd(x(bin_est)));
    num_samps11(i) = double(length(bin_est));
    binned_samps21(i) = double(pmean(y(bin_est)));
    std_samps21(i) = double(pstd(y(bin_est)));
    num_samps21(i) = length(bin_est);
end

% linear least squared regession on binned data

fprintf('\n     Binned least squares regression \r')
[dumb,beta_lin_binned1,S_lin_binned,delta_beta_lin_binned,S_crit_lin_binned]=reg(tbins1(1:length(tbins1)-1),binned_samps21,'lin');
newy_lin_binned1=(beta_lin_binned1(2).*[min_x:step:max_x])+beta_lin_binned1(1);

tbins2=[-.5:.05:.5];
for i=1:length(tbins2)-1
    bin_est = find(x>=tbins2(i) & x<tbins2(i+1));
    binned_samps12(i) = double(pmean(x(bin_est)));
    std_samps12(i) = double(pstd(x(bin_est)));
    num_samps12(i) = double(length(bin_est));
    binned_samps22(i) = double(pmean(y(bin_est)));
    std_samps22(i) = double(pstd(y(bin_est)));
    num_samps22(i) = length(bin_est);
end

% linear least squared regession on binned data

fprintf('\n     Binned least squares regression \r')
[dumb,beta_lin_binned2,S_lin_binned,delta_beta_lin_binned,S_crit_lin_binned]=reg(tbins2(1:length(tbins2)-1),binned_samps22,'lin');
newy_lin_binned2=(beta_lin_binned2(2).*[min_x:step:max_x])+beta_lin_binned2(1);

%}


figure(23)
clf
hold on
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps11,binned_samps21,.5*std_samps21,'k.')
plot([min_x:step:max_x],newy_lin_binned1,'k')

xlabel({'perturbation sst (deg C)  ','',[' \beta_{binned} = ',num2str(beta_lin_binned1(2))]})
ylabel('perturbation wind speed (ms^ {-1})  ')
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
text(-1,1.2,'Midlatitude Eddies')
daspect([1 2 1])

figure(25)
stairs(tbins1(1:end-1),100*(num_samps11./sum(num_samps11(:))),'k')
xlabel('perturbation sst (deg C)  ')
ylabel('%')
axis([-1 1 0 20])
daspect([1 40 1])


print -dpng -r300 figs/histo_sst_wspd_mid_lats


figure(24)
clf
hold on
line([0 0],[min_y max_y],'color','k')
line([min_x max_x],[0 0],'color','k')
errorbar(binned_samps11,binned_samps21,.5*std_samps21,'color',[.5 .5 .5])
plot([min_x:step:max_x],newy_lin_binned1,'color',[.5 .5 .5])
errorbar(binned_samps12,binned_samps22,.5*std_samps22,'k.','linewidth',2)
plot([min_x:step:max_x],newy_lin_binned1,'k','linewidth',2)

xlabel({'perturbation sst (deg C)  ','',[' \beta_{binned} = ',num2str(beta_lin_binned2(2))]})
ylabel('perturbation wind speed (ms^{-1})  ')
axis image
axis([min_x max_x min_y max_y])
box
%daspect([1 2 1])
%axes(cc)
%ylabel('N')
box
text(-1,1.2,'Midlatitude Eddies')
daspect([1 2 1])

print -dpng -r300 figs/coupco_sst_wspd_mid_lats