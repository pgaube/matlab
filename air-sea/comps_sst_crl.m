OUT_HEAD 	= 'SST_CENT_CRL_';
OUT_PATH	= '/Volumes/matlab/matlab/air-sea/sst_cent_samps/'

%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;


%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;


% Create matrices to save jdays
[tcomp_na,tcomp_nc,tcomp_sa,tcomp_sc]=deal(zeros(81,81));
[N_na,N_nc,N_sa,N_sc]=deal(ones(81,81));

for m=3:291-3%:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))]);
    for p=1:length(cent_crl_samps_north_a(1,1,:))
    	obs=cent_crl_samps_north_a(:,:,p);
    	n=~isnan(obs);
    	obs(find(isnan(obs)))=0;
    	tcomp_na=(1./(N_na+n)).*((tcomp_na.*N_na)+(obs.*n));
    	N_na=N_na+n;
    end	
    for p=1:length(cent_crl_samps_north_c(1,1,:))
    	obs=cent_crl_samps_north_c(:,:,p);
    	n=~isnan(obs);
    	obs(find(isnan(obs)))=0;
    	tcomp_nc=(1./(N_nc+n)).*((tcomp_nc.*N_nc)+(obs.*n));
    	N_nc=N_nc+n;
    end	
    for p=1:length(cent_crl_samps_south_a(1,1,:))
    	obs=cent_crl_samps_south_a(:,:,p);
    	n=~isnan(obs);
    	obs(find(isnan(obs)))=0;
    	tcomp_sa=(1./(N_sa+n)).*((tcomp_sa.*N_sa)+(obs.*n));
    	N_sa=N_sa+n;
    end	
    for p=1:length(cent_crl_samps_south_c(1,1,:))
    	obs=cent_crl_samps_south_c(:,:,p);
    	n=~isnan(obs);
    	obs(find(isnan(obs)))=0;
    	tcomp_sc=(1./(N_sc+n)).*((tcomp_sc.*N_sc)+(obs.*n));
    	N_sc=N_sc+n;
    end	

end


tcomp_na(tcomp_na==0)=nan;
tcomp_nc(tcomp_nc==0)=nan;
tcomp_sa(tcomp_sa==0)=nan;
tcomp_sc(tcomp_sc==0)=nan;

fprintf('\n')
