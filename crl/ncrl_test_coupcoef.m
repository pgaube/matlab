
clear all
tbins=[-3e-5:1e-6:-.1e-5 .1e-5:1e-6:3.1e-5];

OUT_HEAD   = 'CRLT_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/crl_test/';

% First load the tracks you want to composite
startjd=2452459;
endjd=2454489;
jdays=[startjd:7:endjd];


% initalize
[tmp_var1,tmp_var2,tmp_var3,tmp_var4,...
tmp_var5,tmp_var6,tmp_var7,tmp_var8,...
tmp_var9,tmp_var10,tmp_var11]=deal(0);

st=1;


for m=1:10%length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
	load([OUT_PATH OUT_HEAD num2str(jdays(1,m))]);

        for pp=1:length(id_index)
            obs1=crl_sample(:,:,pp);
            obs2=ncrl_1_sample(:,:,pp);
            obs3=ncrl_2_sample(:,:,pp);
            obs4=ncrl_3_sample(:,:,pp);
            obs5=ncrl_4_sample(:,:,pp);
            obs6=ncrl_5_sample(:,:,pp);
            obs7=ncrl_6_sample(:,:,pp);
            obs8=ncrl_7_sample(:,:,pp);
            obs9=ncrl_8_sample(:,:,pp);
            obs10=ncrl_9_sample(:,:,pp);
            obs11=ncrl_10_sample(:,:,pp);
            
            ff=find(isnan(obs1));
            obs1(ff)=0;
            obs2(ff)=0;
            obs3(ff)=0;
            obs4(ff)=0;
            obs5(ff)=0;
            obs6(ff)=0;
            obs7(ff)=0;
            obs8(ff)=0;
            obs9(ff)=0;
            obs10(ff)=0;
            obs11(ff)=0;
            
           %{
           nlay=length(obs1(:));
                
                tmp_var1(st:(st+nlay)-1,1)=obs1(:);
                tmp_var2(st:(st+nlay)-1,1)=obs2(:);
                tmp_var3(st:(st+nlay)-1,1)=obs3(:);
                tmp_var4(st:(st+nlay)-1,1)=obs4(:);
                tmp_var5(st:(st+nlay)-1,1)=obs5(:);
                tmp_var6(st:(st+nlay)-1,1)=obs6(:);
                tmp_var7(st:(st+nlay)-1,1)=obs7(:);
                tmp_var8(st:(st+nlay)-1,1)=obs8(:);
                tmp_var9(st:(st+nlay)-1,1)=obs9(:);
                tmp_var10(st:(st+nlay)-1,1)=obs10(:);
                tmp_var11(st:(st+nlay)-1,1)=obs11(:);
                
                st=length(tmp_var1);
                
                %}
                tmp_var1=cat(1,tmp_var1,obs1(:));
                tmp_var2=cat(1,tmp_var2,obs2(:));
                tmp_var3=cat(1,tmp_var3,obs3(:));
                tmp_var4=cat(1,tmp_var4,obs4(:));
                tmp_var5=cat(1,tmp_var5,obs5(:));
                tmp_var6=cat(1,tmp_var6,obs6(:));
                tmp_var7=cat(1,tmp_var7,obs7(:));
                tmp_var8=cat(1,tmp_var8,obs8(:));
                tmp_var9=cat(1,tmp_var9,obs9(:));
                tmp_var10=cat(1,tmp_var10,obs10(:));
                tmp_var11=cat(1,tmp_var11,obs11(:));
                
                
                jj=find(tmp_var1==0);
                tmp_var1(jj)=[];
                tmp_var2(jj)=[];
                tmp_var3(jj)=[];
                tmp_var4(jj)=[];
                tmp_var5(jj)=[];
                tmp_var6(jj)=[];
                tmp_var7(jj)=[];
                tmp_var8(jj)=[];
                tmp_var9(jj)=[];
                tmp_var10(jj)=[];
                tmp_var11(jj)=[];
  

   
end
end


save tmp_crl_coupcoef tmp_*

% do bin averaging
for i=1:length(tbins)-1
    bin_est = find(tmp_var1>=tbins(i) & tmp_var1<tbins(i+1));
    binned_samps_1(i) = pmean(tmp_var1(bin_est));
    binned_samps_2(i) = pmean(tmp_var2(bin_est));
    std_samps_2(i) = pstd(tmp_var2(bin_est));
    num_samps_2(i) = length(bin_est);
    binned_samps_3(i) = pmean(tmp_var3(bin_est));
    std_samps_3(i) = pstd(tmp_var3(bin_est));
    num_samps_3(i) = length(bin_est);
    binned_samps_4(i) = pmean(tmp_var4(bin_est));
    std_samps_4(i) = pstd(tmp_var4(bin_est));
    num_samps_4(i) = length(bin_est);
    binned_samps_5(i) = pmean(tmp_var5(bin_est));
    std_samps_5(i) = pstd(tmp_var5(bin_est));
    num_samps_5(i) = length(bin_est);
    binned_samps_6(i) = pmean(tmp_var6(bin_est));
    std_samps_6(i) = pstd(tmp_var6(bin_est));
    num_samps_6(i) = length(bin_est);
    binned_samps_7(i) = pmean(tmp_var7(bin_est));
    std_samps_7(i) = pstd(tmp_var7(bin_est));
    num_samps_7(i) = length(bin_est);
    binned_samps_8(i) = pmean(tmp_var8(bin_est));
    std_samps_8(i) = pstd(tmp_var8(bin_est));
    num_samps_8(i) = length(bin_est);
    binned_samps_9(i) = pmean(tmp_var9(bin_est));
    std_samps_9(i) = pstd(tmp_var9(bin_est));
    num_samps_9(i) = length(bin_est);
    binned_samps_10(i) = pmean(tmp_var10(bin_est));
    std_samps_10(i) = pstd(tmp_var10(bin_est));
    num_samps_10(i) = length(bin_est);
    binned_samps_11(i) = pmean(tmp_var11(bin_est));
    std_samps_11(i) = pstd(tmp_var11(bin_est));
    num_samps_11(i) = length(bin_est);
end



[newy0,beta0,S0,delta_beta0,S_crit0]=reg(tbins(1:length(tbins)-1),binned_samps_1,'lin');
[newy1,beta1,S1,delta_beta1,S_crit1]=reg(tbins(1:length(tbins)-1),binned_samps_2,'lin');
[newy2,beta2,S2,delta_beta2,S_crit2]=reg(tbins(1:length(tbins)-1),binned_samps_3,'lin');
[newy3,beta3,S3,delta_beta3,S_crit3]=reg(tbins(1:length(tbins)-1),binned_samps_4,'lin');
[newy4,beta4,S4,delta_beta4,S_crit4]=reg(tbins(1:length(tbins)-1),binned_samps_5,'lin');
[newy5,beta5,S5,delta_beta5,S_crit5]=reg(tbins(1:length(tbins)-1),binned_samps_6,'lin');
[newy6,beta6,S6,delta_beta6,S_crit6]=reg(tbins(1:length(tbins)-1),binned_samps_7,'lin');
[newy7,beta7,S7,delta_beta7,S_crit7]=reg(tbins(1:length(tbins)-1),binned_samps_8,'lin');
[newy8,beta8,S8,delta_beta8,S_crit8]=reg(tbins(1:length(tbins)-1),binned_samps_9,'lin');
[newy9,beta9,S9,delta_beta9,S_crit9]=reg(tbins(1:length(tbins)-1),binned_samps_10,'lin');
[newy10,beta10,S10,delta_beta10,S_crit10]=reg(tbins(1:length(tbins)-1),binned_samps_11,'lin');

save ncrl_test_coupcoef tmp_* new* beta* S* delta* *tbins num_* binned_* std_*



fprintf('\n')

figure(1)
clf
plot([.1:.1:1],[beta1(2) beta2(2) beta3(2) beta4(2) beta5(2) beta6(2) beta7(2) beta8(2) beta9(2) beta10(2)],'k')


figure(2)
clf
plot(tbins(1:length(tbins)-1).*1e5,newy10.*1e5,'k')
hold on
errorbar(tbins(1:length(tbins)-1).*1e5,binned_samps_10.*1e5,std_samps_10.*1e5,'g.')
axis([-3 3 -4 4])
title({'\nabla x U_{ntest} binned by \nabla x U_g'})
xlabel('\nabla x U_g [m s^{-1} per 100 km]')
ylabel('\nabla x U_{ntest} [m s^{-1} per 100 km]')
text(.1,-2,['\nabla x U_{ntest} = -', num2str(beta2(2)), '\nabla x U_g'],'color','k')
