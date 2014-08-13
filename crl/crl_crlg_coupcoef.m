
clear all
tbins=[-2e-5:1e-6:2.1e-5];
var1='crlg66_sample';
var2='crl66_sample';
eddies='/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat';



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
startjd=2452459;
endjd=2454489;
jdays=[startjd:7:endjd];


% initalize
[tmp_var1,tmp_var2]=deal(0);

st=1;


for m=1:10%length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'*_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    for pp=1:length(id_index)
            obs1=data1(:,:,pp);
            obs2=data2(:,:,pp);
            obs1(isnan(obs1))=0;
            obs2(isnan(obs2))=0;
            
			tempr=obs1;
            ii=find(abs(obs1)==max(abs(tempr(:))));
            if any(ii)
            tmp_var1=cat(1,tmp_var1,obs1(ii(1)));
            tmp_var2=cat(1,tmp_var2,obs2(ii(1)));
            end

    end       
end           
% do bin averaging
for i=1:length(tbins)-1
    bin_est = find(tmp_var1>=tbins(i) & tmp_var1<tbins(i+1));
    binned_samps(i) = pmean(tmp_var2(bin_est));
    std_samps(i) = pstd(tmp_var2(bin_est));
    num_samps(i) = length(bin_est);
end


[newy,beta,S,delta_beta,S_crit]=reg(tbins(1:length(tbins)-1),binned_samps,'lin');
fprintf('\n')
save crl_crlg_coup *samps tmp_* tbins newy beta S S_crit


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

