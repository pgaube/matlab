
clear all
tbins=[-1:.1:1.1];
var1='foi_sample';
var2='wspd_sample';



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
startjd=2452459;
endjd=2454489;
jdays=[startjd:7:endjd];


% initalize
[tmp_var1,tmp_var2]=deal(0);

st=1;


for m=15:16%length(jdays)
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
            
			
            tmp_var1=cat(1,tmp_var1,obs1(:));
            tmp_var2=cat(1,tmp_var2,obs2(:));
            tmp_var2(tmp_var1==0)=[];
            tmp_var1(tmp_var1==0)=[];
            tmp_var1(tmp_var2==0)=[];
            tmp_var2(tmp_var2==0)=[];
            
            

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
save oi_spd_coup *samps tmp_* tbins newy beta S S_crit


figure(3)
clf
plot(tbins(1:length(tbins)-1),newy,'k')
hold on
errorbar(tbins(1:length(tbins)-1),binned_samps,std_samps,'k.')
axis([-2 2 -1 1])
title({'Wind speed anomaly binned by SST anomaly'})
xlabel({'','SST anomaly (^\circC)',''})
ylabel('wind speed anomaly (ms^{-1})')
text(.5,-1,['\alpha =', num2str(beta(2))],'color','k')

