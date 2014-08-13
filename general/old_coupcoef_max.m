
clear all
tbins=[-2e-5:1e-6:2.1e-5];
var1='crlg66_sample';
var2='crl66_sample';
EDDY_FILE='/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat';



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
load(EDDY_FILE);
startjd=2452459;
endjd=2454489;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
radius=radius(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];

% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);

% initalize
[tmp_var1,tmp_var2]=deal(0);

st=1;


for m=1:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'*_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    ii=sames(uid,id_index);
    if any(ii)
    for pp=1:length(ii)
            obs1=data1(:,:,ii(pp));
            obs2=data2(:,:,ii(pp));
            obs1(isnan(obs1))=0;
            obs2(isnan(obs2))=0;
            
			tempr=obs1;
            mm=find(abs(obs1)==max(abs(tempr(:))));
            if any(mm)
            tmp_var1=cat(1,tmp_var1,obs1(mm(1)));
            tmp_var2=cat(1,tmp_var2,obs2(mm(1)));
            end

    end
    end
end           


clearallbut tmp_var1 tmp_var2 tbins var1 var2

fprintf('\n     flaging \r')
flag=find(isnan(tmp_var1));
tmp_var1(flag)=[];
tmp_var2(flag)=[];
flag=find(isnan(tmp_var2));
tmp_var1(flag)=[];
tmp_var2(flag)=[];
clear flag

% do bin averaging
fprintf('\n     bin averaging \r')
for i=1:length(tbins)-1
    bin_est = find(tmp_var1>=tbins(i) & tmp_var1<tbins(i+1));
    binned_samps1(i) = double(pmean(tmp_var1(bin_est)));
    std_samps1(i) = double(pstd(tmp_var1(bin_est)));
    num_samps1(i) = double(length(bin_est));
    binned_samps2(i) = double(pmean(tmp_var2(bin_est)));
    std_samps2(i) = double(pstd(tmp_var2(bin_est)));
    num_samps2(i) = length(bin_est);
end


% linear least squared regession on binned data
fprintf('\n     Linear least squares regression on binned data \r')
[dumb,beta_lin_binned,S_lin_binned,delta_beta_lin_binned,S_crit_lin_binned]=reg(tbins(1:length(tbins)-1),binned_samps2,'lin');
newy_lin_binned=(beta_lin_binned(2).*binned_samps1)+beta_lin_binned(1);

%{
% linear least squared regession on samples
fprintf('\n     Linear least squares regression on samples \r')
[dumb,beta_lin_samps,S,delta_beta_lin_samps,S_crit_lin_samps]=reg(tmp_var1,tmp_var2,'lin');
newy_lin_samps=(beta_lin_samps(2).*binned_samps1)+beta_lin_samps(1);
%}

% neutral least squared regession on binned averages
fprintf('\n     Neutral least squares regression on binned averages \r')
[beta_nut_binned(2),beta_nut_binned(1)]=wtls_line(binned_samps1,binned_samps2,ones(size(binned_samps2)).*1e5,ones(size(binned_samps2)).*1e5);
newy_nut_binned=(beta_nut_binned(2).*binned_samps1)+beta_nut_binned(1);

% neutral least squared regession on samples
fprintf('\n     Neutral least squares regression on samples \r')
[beta_nut_samps(2),beta_nut_samps(1)]=wtls_line(double(tmp_var1),double(tmp_var2),ones(size(tmp_var2)).*1e5,ones(size(tmp_var2)).*2e5);
newy_nut_samps=(beta_nut_samps(2).*binned_samps1)+beta_nut_samps(1);

fprintf('\n')
eval(['save ' var1 '_' var2 '_coupcoef_max tmp_var* *samps* tbins newy* beta* var1 var2'])

return
figure(3)
clf
plot(tbins(1:length(tbins)-1).*1e5,newy.*1e5,'k')
hold on
errorbar(tbins(1:length(tbins)-1).*1e5,binned_samps.*1e5,std_samps.*1e5,'k.')
axis([-2 2 -3 3])
title({'\nabla x U_m binned by \nabla x U_g','5 weeks, both filtered with same span'})
xlabel({'','\nabla x U_g [m s^{-1} per 100 km]',''})
ylabel('\nabla x U_m [m s^{-1} per 100 km]')
text(-1,-2,['\nabla x U_m = ', num2str(beta(2)), ' \nabla x U_g'],'color','k')

