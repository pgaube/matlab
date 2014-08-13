clear
load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;




%start with the leeuwin, naturaly,

load ebc_samps/lw_anom_samps

% make indices
ai=find(lw_ids>=nneg);
ci=find(lw_ids<nneg);
uid = unique(lw_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
lw_nanom_bar=nan.*lw_anom_bar;


for m=1:length(uid)
	ii = find(lw_ids==uid(m));
	lw_sel_stage(ii) = lw_k(ii)./lw_k(ii(length(ii)));
	%qq=find(lw_k(ii)==1);
	qq=find(lw_k(ii)>=1 & lw_k(ii)<=2);
	if any(qq)
		tmp = lw_anom_bar(ii(qq));
		atmp = pmean(lw_amp(ii(qq)));
		lw_nanom_bar(ii) = lw_anom_bar(ii)./pmean(tmp(:));
		lw_namp(ii)  = lw_amp(ii)./atmp;
	else
		lw_nanom_bar(ii)=nan;
		lw_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(lw_k(ai)>=tbins(i) & lw_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(lw_N(ai(bin_est))))*nansum(lw_nanom_bar(ai(bin_est)).*lw_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(lw_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(lw_N(ai(bin_est))))*nansum(lw_anom_bar(ai(bin_est)).*lw_N(ai(bin_est)));
    	std_anom_a(i) = pstd(lw_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(lw_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(lw_namp(ai(bin_est)));

    	
    	bin_est = find(lw_k(ci)>=tbins(i) & lw_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(lw_N(ci(bin_est))))*nansum(lw_nanom_bar(ci(bin_est)).*lw_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(lw_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(lw_N(ci(bin_est))))*nansum(lw_anom_bar(ci(bin_est)).*lw_N(ci(bin_est)));
    	std_anom_c(i) = pstd(lw_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(lw_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(lw_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/lw_chl_anom_binned
clear

load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;



%next is alaska

load ebc_samps/ak_anom_samps

% make indices
ai=find(ak_ids>=nneg);
ci=find(ak_ids<nneg);
uid = unique(ak_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
ak_nanom_bar=nan.*ak_anom_bar;


for m=1:length(uid)
	ii = find(ak_ids==uid(m));
	ak_sel_stage(ii) = ak_k(ii)./ak_k(ii(length(ii)));
	%qq=find(ak_k(ii)==1);
	qq=find(ak_k(ii)>=1 & ak_k(ii)<=2);
	if any(qq)
		tmp = ak_anom_bar(ii(qq));
		atmp = pmean(ak_amp(ii(qq)));
		ak_nanom_bar(ii) = ak_anom_bar(ii)./pmean(tmp(:));
		ak_namp(ii)  = ak_amp(ii)./atmp;
	else
		ak_nanom_bar(ii)=nan;
		ak_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(ak_k(ai)>=tbins(i) & ak_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(ak_N(ai(bin_est))))*nansum(ak_nanom_bar(ai(bin_est)).*ak_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(ak_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(ak_N(ai(bin_est))))*nansum(ak_anom_bar(ai(bin_est)).*ak_N(ai(bin_est)));
    	std_anom_a(i) = pstd(ak_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(ak_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(ak_namp(ai(bin_est)));

    	
    	bin_est = find(ak_k(ci)>=tbins(i) & ak_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(ak_N(ci(bin_est))))*nansum(ak_nanom_bar(ci(bin_est)).*ak_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(ak_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(ak_N(ci(bin_est))))*nansum(ak_anom_bar(ci(bin_est)).*ak_N(ci(bin_est)));
    	std_anom_c(i) = pstd(ak_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(ak_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(ak_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/ak_chl_anom_binned
clear


% Finaly we finish off the Norther Hemisphere's portion of the Atlantic with the Canary Current,
% well at least the southern end of it, wich we just call the Canary Current (or cc for short)


load ebc_samps/cc_anom_samps
load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;

% make indices
ai=find(cc_ids>=nneg);
ci=find(cc_ids<nneg);
uid = unique(cc_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
cc_nanom_bar=nan.*cc_anom_bar;


for m=1:length(uid)
	ii = find(cc_ids==uid(m));
	cc_sel_stage(ii) = cc_k(ii)./cc_k(ii(length(ii)));
	%qq=find(cc_k(ii)==1);
	qq=find(cc_k(ii)>=1 & cc_k(ii)<=2);
	if any(qq)
		tmp = cc_anom_bar(ii(qq));
		atmp = pmean(cc_amp(ii(qq)));
		cc_nanom_bar(ii) = cc_anom_bar(ii)./pmean(tmp(:));
		cc_namp(ii)  = cc_amp(ii)./atmp;
	else
		cc_nanom_bar(ii)=nan;
		cc_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(cc_k(ai)>=tbins(i) & cc_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(cc_N(ai(bin_est))))*nansum(cc_nanom_bar(ai(bin_est)).*cc_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(cc_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(cc_N(ai(bin_est))))*nansum(cc_anom_bar(ai(bin_est)).*cc_N(ai(bin_est)));
    	std_anom_a(i) = pstd(cc_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(cc_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(cc_namp(ai(bin_est)));

    	
    	bin_est = find(cc_k(ci)>=tbins(i) & cc_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(cc_N(ci(bin_est))))*nansum(cc_nanom_bar(ci(bin_est)).*cc_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(cc_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(cc_N(ci(bin_est))))*nansum(cc_anom_bar(ci(bin_est)).*cc_N(ci(bin_est)));
    	std_anom_c(i) = pstd(cc_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(cc_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(cc_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/cc_chl_anom_binned
clear



% Shave your head as you cross the equator for the first time and sample the Benguela Current (bg)

load ebc_samps/bg_anom_samps
load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;

% make indices
ai=find(bg_ids>=nneg);
ci=find(bg_ids<nneg);
uid = unique(bg_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
bg_nanom_bar=nan.*bg_anom_bar;


for m=1:length(uid)
	ii = find(bg_ids==uid(m));
	bg_sel_stage(ii) = bg_k(ii)./bg_k(ii(length(ii)));
	%qq=find(bg_k(ii)==1);
	qq=find(bg_k(ii)>=1 & bg_k(ii)<=2);
	if any(qq)
		tmp = bg_anom_bar(ii(qq));
		atmp = pmean(bg_amp(ii(qq)));
		bg_nanom_bar(ii) = bg_anom_bar(ii)./pmean(tmp(:));
		bg_namp(ii)  = bg_amp(ii)./atmp;
	else
		bg_nanom_bar(ii)=nan;
		bg_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(bg_k(ai)>=tbins(i) & bg_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(bg_N(ai(bin_est))))*nansum(bg_nanom_bar(ai(bin_est)).*bg_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(bg_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(bg_N(ai(bin_est))))*nansum(bg_anom_bar(ai(bin_est)).*bg_N(ai(bin_est)));
    	std_anom_a(i) = pstd(bg_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(bg_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(bg_namp(ai(bin_est)));

    	
    	bin_est = find(bg_k(ci)>=tbins(i) & bg_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(bg_N(ci(bin_est))))*nansum(bg_nanom_bar(ci(bin_est)).*bg_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(bg_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(bg_N(ci(bin_est))))*nansum(bg_anom_bar(ci(bin_est)).*bg_N(ci(bin_est)));
    	std_anom_c(i) = pstd(bg_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(bg_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(bg_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/bg_chl_anom_binned
clear

% Fly on over to the Pacific basin and start out to the north with California Current (ccnss)

load ebc_samps/ccns_anom_samps
load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;

% make indices
ai=find(ccns_ids>=nneg);
ci=find(ccns_ids<nneg);
uid = unique(ccns_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
ccns_nanom_bar=nan.*ccns_anom_bar;


for m=1:length(uid)
	ii = find(ccns_ids==uid(m));
	ccns_sel_stage(ii) = ccns_k(ii)./ccns_k(ii(length(ii)));
	%qq=find(ccns_k(ii)==1);
	qq=find(ccns_k(ii)>=1 & ccns_k(ii)<=2);
	if any(qq)
		tmp = ccns_anom_bar(ii(qq));
		atmp = pmean(ccns_amp(ii(qq)));
		ccns_nanom_bar(ii) = ccns_anom_bar(ii)./pmean(tmp(:));
		ccns_namp(ii)  = ccns_amp(ii)./atmp;
	else
		ccns_nanom_bar(ii)=nan;
		ccns_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(ccns_k(ai)>=tbins(i) & ccns_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(ccns_N(ai(bin_est))))*nansum(ccns_nanom_bar(ai(bin_est)).*ccns_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(ccns_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(ccns_N(ai(bin_est))))*nansum(ccns_anom_bar(ai(bin_est)).*ccns_N(ai(bin_est)));
    	std_anom_a(i) = pstd(ccns_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(ccns_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(ccns_namp(ai(bin_est)));

    	
    	bin_est = find(ccns_k(ci)>=tbins(i) & ccns_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(ccns_N(ci(bin_est))))*nansum(ccns_nanom_bar(ci(bin_est)).*ccns_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(ccns_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(ccns_N(ci(bin_est))))*nansum(ccns_anom_bar(ci(bin_est)).*ccns_N(ci(bin_est)));
    	std_anom_c(i) = pstd(ccns_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(ccns_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(ccns_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/ccns_chl_anom_binned
clear


%pc

load ebc_samps/pc_anom_samps
load /Volumes/matlab/data/eddy/V3/global_tracks_V3 nneg
c=73;  %location of eddy center that has been interperlated to the 4km grid
dt=2;
tdt=5;
tbins=1:dt:101;

% make indices
ai=find(pc_ids>=nneg);
ci=find(pc_ids<nneg);
uid = unique(pc_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

% Normalize each eddy by the mean achl in the first five time steps
pc_nanom_bar=nan.*pc_anom_bar;


for m=1:length(uid)
	ii = find(pc_ids==uid(m));
	pc_sel_stage(ii) = pc_k(ii)./pc_k(ii(length(ii)));
	%qq=find(pc_k(ii)==1);
	qq=find(pc_k(ii)>=1 & pc_k(ii)<=2);
	if any(qq)
		tmp = pc_anom_bar(ii(qq));
		atmp = pmean(pc_amp(ii(qq)));
		pc_nanom_bar(ii) = pc_anom_bar(ii)./pmean(tmp(:));
		pc_namp(ii)  = pc_amp(ii)./atmp;
	else
		pc_nanom_bar(ii)=nan;
		pc_namp(ii)=nan;
	end
end	

%next we need to calculate the bin averages
%prealocate to save jdays
bar_nanom_a=nan(size(tbins));
bar_nanom_c=nan(size(tbins));
bar_anom_a=nan(size(tbins));
bar_anom_c=nan(size(tbins));
bar_namp_a=nan(size(tbins));
bar_namp_c=nan(size(tbins));
std_nanom_a=nan(size(tbins));
std_nanom_c=nan(size(tbins));
std_anom_a=nan(size(tbins));
std_anom_c=nan(size(tbins));
std_namp_a=nan(size(tbins));
std_namp_c=nan(size(tbins));

%now do the bin averaging


 for i=1:length(tbins)-1
        bin_est = find(pc_k(ai)>=tbins(i) & pc_k(ai)<tbins(i+1));
        bar_nanom_a(i) = (1./nansum(pc_N(ai(bin_est))))*nansum(pc_nanom_bar(ai(bin_est)).*pc_N(ai(bin_est)));
    	std_nanom_a(i) = pstd(pc_nanom_bar(ai(bin_est)));
        
        bar_anom_a(i) = (1./nansum(pc_N(ai(bin_est))))*nansum(pc_anom_bar(ai(bin_est)).*pc_N(ai(bin_est)));
    	std_anom_a(i) = pstd(pc_nanom_bar(ai(bin_est)));
    	
    	bar_namp_a(i)  = pmean(pc_namp(ai(bin_est)));
 	   	std_namp_a(i)  = pstd(pc_namp(ai(bin_est)));

    	
    	bin_est = find(pc_k(ci)>=tbins(i) & pc_k(ci)<tbins(i+1));
        bar_nanom_c(i) = (1./nansum(pc_N(ci(bin_est))))*nansum(pc_nanom_bar(ci(bin_est)).*pc_N(ci(bin_est)));
    	std_nanom_c(i) = pstd(pc_nanom_bar(ci(bin_est)));
        
        bar_anom_c(i) = (1./nansum(pc_N(ci(bin_est))))*nansum(pc_anom_bar(ci(bin_est)).*pc_N(ci(bin_est)));
    	std_anom_c(i) = pstd(pc_nanom_bar(ci(bin_est)));
    	
    	bar_namp_c(i)  = pmean(pc_namp(ci(bin_est)));
        std_namp_c(i)  = pstd(pc_namp(ci(bin_est)));

  end 	

save ebc_binned_samps/pc_chl_anom_binned
clear

