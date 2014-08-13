
clear all
tbins=[-3e-5:1e-6:-.1e-5 .1e-5:1e-6:3.1e-5];
var1='crlg_sample';
var2='crl_sample';



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
load(EDDY_FILE);
startjd=2452459;
endjd=2454489;
jdays=[startjd:7:endjd];


% initalize
[tmp_var1,tmp_var2,tmp_var3,tmp_var4,...
tmp_var5,tmp_var6,tmp_var7,tmp_var8,...
tmp_var9,tmp_var10,tmp_var11]=deal(0);

st=1;


for m=1:50%length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(1,m))],var1,var2,'*_index');
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
            
            
			tmp_var1=cat(1,tmp_var1,obs1(:));
            tmp_var2=cat(1,tmp_var2,obs2(:));
            
            tmp_var1(tmp_var1==0)=[];
            tmp_var2(tmp_var1==0)=[];
            tmp_var1(tmp_var2==0)=[];
            tmp_var2(tmp_var2==0)=[];
            
            
            
            if id_index(ii(pp))>=nneg;
                tmp_var1_a(st_1_a:(st_1_a+nlay_1)-1,1)=obs1(:);
                tmp_var2_a(st_2_a:(st_2_a+nlay_2)-1,1)=obs2(:);
                jj=find(tmp_var1_a==0);
                tmp_var1_a(jj)=[];
                tmp_var2_a(jj)=[];
                jj=find(tmp_var2_a==0);
                tmp_var1_a(jj)=[];
                tmp_var2_a(jj)=[];
                st_1_a=length(tmp_var1_a);
                st_2_a=length(tmp_var2_a);
                if(st_1_a==0) st_1_a=1
                if(st_2_a==0) st_2_a=1
                end
                end

            else
                tmp_var1_c(st_1_c:(st_1_c+nlay_1)-1,1)=obs1(:);
                tmp_var2_c(st_2_c:(st_2_c+nlay_2)-1,1)=obs2(:);
                jj=find(tmp_var1_c==0);
                tmp_var1_c(jj)=[];
                tmp_var2_c(jj)=[];
                jj=find(tmp_var2_c==0);
                tmp_var1_c(jj)=[];
                tmp_var2_c(jj)=[];
                st_1_c=length(tmp_var1_c);
                st_2_c=length(tmp_var2_c);
                if(st_1_c==0) st_1_c=1
                if(st_2_c==0) st_2_c=1
                end
                end
            end
        end
    end
    %whos tmp_var*
end



tmp_var1_a(tmp_var1_a==0)=nan;
tmp_var1_c(tmp_var1_c==0)=nan;
tmp_var2_a(tmp_var2_a==0)=nan;
tmp_var2_c(tmp_var2_c==0)=nan;
tmp_var1=cat(1,tmp_var1_a,tmp_var1_c);
tmp_var2=cat(1,tmp_var2_a,tmp_var2_c);

save tmp_crl_coupcoef tmp_*

% do bin averaging
for i=1:length(atbins)-1
    bin_est = find(tmp_var1_a>=atbins(i) & tmp_var1_a<atbins(i+1));
    binned_samps_a(i) = pmean(tmp_var2_a(bin_est));
    std_samps_a(i) = pstd(tmp_var2_a(bin_est));
    num_samps_a(i) = length(bin_est);
end

for i=1:length(ctbins)-1
    bin_est = find(tmp_var1_c>=ctbins(i) & tmp_var1_c<ctbins(i+1));
    binned_samps_c(i) = pmean(tmp_var2_c(bin_est));
    std_samps_c(i) = pstd(tmp_var2_c(bin_est));
    num_samps_c(i) = length(bin_est);
end

[newy,beta,S,delta_beta,S_crit]=reg([atbins(1:length(atbins)-1) ctbins(1:length(ctbins)-1)],[binned_samps_a binned_samps_c],'lin');
fprintf('\n')

clf
plot([atbins(1:length(atbins)-1) ctbins(1:length(ctbins)-1)].*1e5,newy.*1e5,'k')
hold on
errorbar(atbins(1:length(atbins)-1).*1e5,binned_samps_a.*1e5,std_samps_a.*1e5,'r.')
errorbar(ctbins(1:length(ctbins)-1).*1e5,binned_samps_c.*1e5,std_samps_c.*1e5,'b.')
axis([-3 3 -4 4])
title({'\nabla x U_{10} binned by \nabla x U_g','northern midlatitude eddies 100 weeks'})
xlabel('\nabla x U_g [m s^{-1} per 100 km')
ylabel('\nabla x U_{10} [m s^{-1} per 100 km')
text(.1,-2,['\nabla x U_{10} = -', num2str(beta(2)), '\nabla x U_g'],'color','k')

