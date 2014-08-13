
clear all
EDDY_FILE='/Volumes/matlab/matlab/south/south_tracks_16_weeks.mat';
ctbins=[-3e-5:1e-6:0];
atbins=[.1e-5:1e-6:3.1e-5];
var1='crlg_sample';
var2='crl_1_sample';
var3='crl_2_sample';
var4='crl_3_sample';
var5='crl_4_sample';
var6='crl_5_sample';
var7='crl_6_sample';
var8='crl_7_sample';
var9='crl_8_sample';
var10='crl_9_sample';
var11='crl_10_sample';




OUT_HEAD   = 'CRLT_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/crl_test/';

G_HEAD   = 'TRANS_W_';
G_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
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
[tmp_var1_a,tmp_var1_c,tmp_var2_a,tmp_var2_c,tmp_var3_a,tmp_var3_c,tmp_var4_a,tmp_var4_c,...
tmp_var5_a,tmp_var5_c,tmp_var6_a,tmp_var6_c,tmp_var7_a,tmp_var7_c,tmp_var8_a,tmp_var8_c,...
tmp_var9_a,tmp_var9_c,tmp_var10_a,tmp_var10_c,tmp_var11_a,tmp_var11_c,]=deal(0);


for m=1:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([G_PATH G_HEAD num2str(jdays(1,m))],var1);
	load([OUT_PATH OUT_HEAD num2str(jdays(1,m))]);
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    eval(['data3 = ' var3 ';'])
    eval(['data4 = ' var4 ';'])
    eval(['data5 = ' var5 ';'])
    eval(['data6 = ' var6 ';'])
    eval(['data7 = ' var7 ';'])
    eval(['data8 = ' var8 ';'])
    eval(['data9 = ' var9 ';'])
    eval(['data10 = ' var10 ';'])
    eval(['data11 = ' var11 ';'])
    %size(data)
    
    ii=sames(uid,id_index);
    if any(ii)
        for pp=1:length(ii)
            obs1=data1(:,:,ii(pp));
            obs2=data2(:,:,ii(pp));
            obs3=data3(:,:,ii(pp));
            obs4=data4(:,:,ii(pp));
            obs5=data5(:,:,ii(pp));
            obs6=data6(:,:,ii(pp));
            obs7=data7(:,:,ii(pp));
            obs8=data8(:,:,ii(pp));
            obs9=data9(:,:,ii(pp));
            obs10=data10(:,:,ii(pp));
            obs11=data11(:,:,ii(pp));
            
            obs1(isnan(obs1))=0;
            obs2(isnan(obs2))=0;
            obs3(isnan(obs3))=0;
            obs4(isnan(obs4))=0;
            obs5(isnan(obs5))=0;
            obs6(isnan(obs6))=0;
            obs7(isnan(obs7))=0;
            obs8(isnan(obs8))=0;
            obs9(isnan(obs9))=0;
            obs10(isnan(obs10))=0;
            obs11(isnan(obs11))=0;
            
            if id_index(ii(pp))>=nneg;
                tmp_var1_a=cat(1,tmp_var1_a,obs1(:));
                tmp_var2_a=cat(1,tmp_var2_a,obs2(:));
                tmp_var3_a=cat(1,tmp_var3_a,obs3(:));
                tmp_var4_a=cat(1,tmp_var4_a,obs4(:));
                tmp_var5_a=cat(1,tmp_var5_a,obs5(:));
                tmp_var6_a=cat(1,tmp_var6_a,obs6(:));
                tmp_var7_a=cat(1,tmp_var7_a,obs7(:));
                tmp_var8_a=cat(1,tmp_var8_a,obs8(:));
                tmp_var9_a=cat(1,tmp_var9_a,obs9(:));
                tmp_var10_a=cat(1,tmp_var10_a,obs10(:));
                tmp_var11_a=cat(1,tmp_var11_a,obs11(:));
                
                jj=find(tmp_var1_a==0);
                tmp_var1_a(jj)=[];
                tmp_var2_a(jj)=[];
                tmp_var3_a(jj)=[];
                tmp_var4_a(jj)=[];
                tmp_var5_a(jj)=[];
                tmp_var6_a(jj)=[];
                tmp_var7_a(jj)=[];
                tmp_var8_a(jj)=[];
                tmp_var9_a(jj)=[];
                tmp_var10_a(jj)=[];
                tmp_var11_a(jj)=[];
  

            else
                tmp_var1_c=cat(1,tmp_var1_c,obs1(:));
                tmp_var2_c=cat(1,tmp_var2_c,obs2(:));
                tmp_var3_c=cat(1,tmp_var3_c,obs3(:));
                tmp_var4_c=cat(1,tmp_var4_c,obs4(:));
                tmp_var5_c=cat(1,tmp_var5_c,obs5(:));
                tmp_var6_c=cat(1,tmp_var6_c,obs6(:));
                tmp_var7_c=cat(1,tmp_var7_c,obs7(:));
                tmp_var8_c=cat(1,tmp_var8_c,obs8(:));
                tmp_var9_c=cat(1,tmp_var9_c,obs9(:));
                tmp_var10_c=cat(1,tmp_var10_c,obs10(:));
                tmp_var11_c=cat(1,tmp_var11_c,obs11(:));
                
                jj=find(tmp_var1_c==0);
                tmp_var1_c(jj)=[];
                tmp_var2_c(jj)=[];
                tmp_var3_c(jj)=[];
                tmp_var4_c(jj)=[];
                tmp_var5_c(jj)=[];
                tmp_var6_c(jj)=[];
                tmp_var7_c(jj)=[];
                tmp_var8_c(jj)=[];
                tmp_var9_c(jj)=[];
                tmp_var10_c(jj)=[];
                tmp_var11_c(jj)=[];
                
            end
        end
    end
    %whos tmp_var*
end


save tmp_crl_coupcoef tmp_*

% do bin averaging
for i=1:length(atbins)-1
    bin_est = find(tmp_var1_a>=atbins(i) & tmp_var1_a<atbins(i+1));
    binned_samps_1_a(i) = pmean(tmp_var1_a(bin_est));
    binned_samps_2_a(i) = pmean(tmp_var2_a(bin_est));
    std_samps_2_a(i) = pstd(tmp_var2_a(bin_est));
    num_samps_2_a(i) = length(bin_est);
    binned_samps_3_a(i) = pmean(tmp_var3_a(bin_est));
    std_samps_3_a(i) = pstd(tmp_var3_a(bin_est));
    num_samps_3_a(i) = length(bin_est);
    binned_samps_4_a(i) = pmean(tmp_var4_a(bin_est));
    std_samps_4_a(i) = pstd(tmp_var4_a(bin_est));
    num_samps_4_a(i) = length(bin_est);
    binned_samps_5_a(i) = pmean(tmp_var5_a(bin_est));
    std_samps_5_a(i) = pstd(tmp_var5_a(bin_est));
    num_samps_5_a(i) = length(bin_est);
    binned_samps_6_a(i) = pmean(tmp_var6_a(bin_est));
    std_samps_6_a(i) = pstd(tmp_var6_a(bin_est));
    num_samps_6_a(i) = length(bin_est);
    binned_samps_7_a(i) = pmean(tmp_var7_a(bin_est));
    std_samps_7_a(i) = pstd(tmp_var7_a(bin_est));
    num_samps_7_a(i) = length(bin_est);
    binned_samps_8_a(i) = pmean(tmp_var8_a(bin_est));
    std_samps_8_a(i) = pstd(tmp_var8_a(bin_est));
    num_samps_8_a(i) = length(bin_est);
    binned_samps_9_a(i) = pmean(tmp_var9_a(bin_est));
    std_samps_9_a(i) = pstd(tmp_var9_a(bin_est));
    num_samps_9_a(i) = length(bin_est);
    binned_samps_10_a(i) = pmean(tmp_var10_a(bin_est));
    std_samps_10_a(i) = pstd(tmp_var10_a(bin_est));
    num_samps_10_a(i) = length(bin_est);
    binned_samps_11_a(i) = pmean(tmp_var11_a(bin_est));
    std_samps_11_a(i) = pstd(tmp_var11_a(bin_est));
    num_samps_11_a(i) = length(bin_est);
end

for i=1:length(ctbins)-1
    bin_est = find(tmp_var1_c>=ctbins(i) & tmp_var1_c<ctbins(i+1));
    binned_samps_1_c(i) = pmean(tmp_var1_c(bin_est));
    binned_samps_2_c(i) = pmean(tmp_var2_c(bin_est));
    std_samps_2_c(i) = pstd(tmp_var2_c(bin_est));
    num_samps_2_c(i) = length(bin_est);
    binned_samps_3_c(i) = pmean(tmp_var3_c(bin_est));
    std_samps_3_c(i) = pstd(tmp_var3_c(bin_est));
    num_samps_3_c(i) = length(bin_est);
    binned_samps_4_c(i) = pmean(tmp_var4_c(bin_est));
    std_samps_4_c(i) = pstd(tmp_var4_c(bin_est));
    num_samps_4_c(i) = length(bin_est);
    binned_samps_5_c(i) = pmean(tmp_var5_c(bin_est));
    std_samps_5_c(i) = pstd(tmp_var5_c(bin_est));
    num_samps_5_c(i) = length(bin_est);
    binned_samps_6_c(i) = pmean(tmp_var6_c(bin_est));
    std_samps_6_c(i) = pstd(tmp_var6_c(bin_est));
    num_samps_6_c(i) = length(bin_est);
    binned_samps_7_c(i) = pmean(tmp_var7_c(bin_est));
    std_samps_7_c(i) = pstd(tmp_var7_c(bin_est));
    num_samps_7_c(i) = length(bin_est);
    binned_samps_8_c(i) = pmean(tmp_var8_c(bin_est));
    std_samps_8_c(i) = pstd(tmp_var8_c(bin_est));
    num_samps_8_c(i) = length(bin_est);
    binned_samps_9_c(i) = pmean(tmp_var9_c(bin_est));
    std_samps_9_c(i) = pstd(tmp_var9_c(bin_est));
    num_samps_9_c(i) = length(bin_est);
    binned_samps_10_c(i) = pmean(tmp_var10_c(bin_est));
    std_samps_10_c(i) = pstd(tmp_var10_c(bin_est));
    num_samps_10_c(i) = length(bin_est);
    binned_samps_11_c(i) = pmean(tmp_var11_c(bin_est));
    std_samps_11_c(i) = pstd(tmp_var11_c(bin_est));
    num_samps_11_c(i) = length(bin_est);
end

[newy0,beta0,S0,delta_beta0,S_crit0]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_1_c binned_samps_1_a],'lin');
[newy1,beta1,S1,delta_beta1,S_crit1]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_2_c binned_samps_2_a],'lin');
[newy2,beta2,S2,delta_beta2,S_crit2]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_3_c binned_samps_3_a],'lin');
[newy3,beta3,S3,delta_beta3,S_crit3]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_4_c binned_samps_4_a],'lin');
[newy4,beta4,S4,delta_beta4,S_crit4]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_5_c binned_samps_5_a],'lin');
[newy5,beta5,S5,delta_beta5,S_crit5]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_6_c binned_samps_6_a],'lin');
[newy6,beta6,S6,delta_beta6,S_crit6]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_7_c binned_samps_7_a],'lin');
[newy7,beta7,S7,delta_beta7,S_crit7]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_8_c binned_samps_8_a],'lin');
[newy8,beta8,S8,delta_beta8,S_crit8]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_9_c binned_samps_9_a],'lin');
[newy9,beta9,S9,delta_beta9,S_crit9]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_10_c binned_samps_10_a],'lin');
[newy10,beta10,S10,delta_beta10,S_crit10]=reg([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)],[binned_samps_11_c binned_samps_11_a],'lin');

save crl_test_coupcoef tmp_* new* beta* S* delta* *tbins num_* binned_* std_*



fprintf('\n')

figure(1)
clf
plot([.1:.1:1],[beta1(2) beta2(2) beta3(2) beta4(2) beta5(2) beta6(2) beta7(2) beta8(2) beta9(2) beta10(2)],'k')


figure(2)
clf
plot([ctbins(1:length(ctbins)-1) atbins(1:length(atbins)-1)].*1e5,newy2.*1e5,'k')
hold on
errorbar(atbins(1:length(atbins)-1).*1e5,binned_samps_2_a.*1e5,std_samps_2_a.*1e5,'r.')
errorbar(ctbins(1:length(ctbins)-1).*1e5,binned_samps_2_c.*1e5,std_samps_2_c.*1e5,'b.')
axis([-3 3 -4 4])
title({'\nabla x U_{test} binned by \nabla x U_g','northern midlatitude eddies 100 weeks'})
xlabel('\nabla x U_g [m s^{-1} per 100 km]')
ylabel('\nabla x U_{test} [m s^{-1} per 100 km]')
text(.1,-2,['\nabla x U_{10} = -', num2str(beta2(2)), '\nabla x U_g'],'color','k')
