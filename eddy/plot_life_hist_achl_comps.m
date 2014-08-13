

%close all
%clear all
%load /Volumes/matlab/matlab/leeuwin/leeuwin_orgin_select_16_80_weeks.mat



% Subset samples based off of eddy file

% make indices
ai=find(sel_ids>=nneg);
ci=find(sel_ids<nneg);


uid = unique(sel_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);

N=~isnan(sel_anom);

dt=3;
tdt=2;
tbins=1:dt:max(sel_k)+1;

bar_achla=nan(145,145,length(tbins));
bar_achlc=nan(145,145,length(tbins));
num_achla=nan(size(tbins));
num_achlc=nan(size(tbins));
num_anti=nan(size(tbins));
num_cycl=nan(size(tbins));

 for i=1:length(tbins)-1
        bin_est = find(sel_k(ai)>=tbins(i) & sel_k(ai)<tbins(i+1));
        num_anti(i) = length(unique(sel_ids(ai(bin_est))));
        bar_achla(:,:,i) = (1./nansum(N(:,:,ai(bin_est)),3)).*nansum(sel_anom(:,:,ai(bin_est)).*N(:,:,ai(bin_est)),3);
    	num_achla(i) = length(find(~isnan(sel_anom(:,:,ai(bin_est)))));
    	
    	bin_est = find(sel_k(ci)>=tbins(i) & sel_k(ci)<tbins(i+1));
    	num_cycl(i) = length(unique(sel_ids(ci(bin_est))));
        bar_achlc(:,:,i) = (1./nansum(N(:,:,ci(bin_est)),3)).*nansum(sel_anom(:,:,ci(bin_est)).*N(:,:,ci(bin_est)),3);
		num_achlc(i) = length(find(~isnan(sel_anom(:,:,ci(bin_est)))));
  end 	

figure(1)
clf
for m=1:27
	subplot(5,6,m)
	pcolor(bar_achla(:,:,m));shading flat
	caxis([-.2 .2])
	title(['k = ', num2str(tbins(m)),'  ', 'Num Eddies = ', num2str(num_anti(m))])
end



figure(2)
clf
for m=1:27
	subplot(5,6,m)
	pcolor(bar_achlc(:,:,m));shading flat
	caxis([-.2 .2])
	title(['k = ', num2str(tbins(m)), '  ', 'Num Eddies = ', num2str(num_cycl(m))])
end	
