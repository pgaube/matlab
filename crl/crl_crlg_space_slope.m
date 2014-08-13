
clear all
tbins=[-2e-5:1e-6:2.1e-5];
var1='nrcrlg66_sample';
var2='nrcrl66_sample';



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
startjd=2452459;
endjd=2454489;
jdays=[startjd:7:endjd];


% initalize
st=1;


for m=1:10%length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(1,m))],var1,var2,'*_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    for pp=1:length(id_index)
            obs1=data1(:,:,pp);
            obs2=data2(:,:,pp);
            obs1(isnan(obs1))=0;
            obs2(isnan(obs2))=0;
            
			tmp_var1(:,:,st)=obs1;
            tmp_var2(:,:,st)=obs2;
            st=st+1;
    end       
end        

save tmp_crl_crlg_space_slope tmp* tbins *_index

% do bin averaging
for m=1:length(tmp_var1(:,1,1))
	for n=1:length(tmp_var1(1,:,1))
		for i=1:length(tbins)-1
    	bin_est = find(tmp_var1(m,n,:)>=tbins(i) & tmp_var1(m,n,:)<tbins(i+1));
   	 	if any(bin_est)
   	 		binned_samps(m,n,i) = pmean(tmp_var2(m,n,bin_est));
    		std_samps(m,n,i) = pstd(tmp_var2(m,n,bin_est));
    		num_samps(m,n,i) = length(bin_est);
    	else
    		binned_samps(m,n,i) = nan;
    		std_samps(m,n,i) = nan;
    		num_samps(m,n,i) = nan;
    	end	
    	end
    [newy(m,n,:),beta(m,n,:),S(m,n),delta_beta(m,n,:),S_crit(m,n)] = ...
    	 reg(tbins(1:length(tbins)-1),squeeze(binned_samps(m,n,:)),'lin');	
    end	
end


fprintf('\n')

save crl_crlg_space_slope *samps tmp_* tbins newy beta S delta_beta S_crit

clf
pcolor(double(beta(:,:,2)));shading flat


