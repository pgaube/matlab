
%close all
%clear all
%load /Volumes/matlab/matlab/leeuwin/leeuwin_orgin_select_16_80_weeks.mat
c=73;


% Subset samples based off of eddy file

% make indices
ai=find(sel_ids>=nneg);
ci=find(sel_ids<nneg);


uid = unique(sel_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);



% average the spatial chl of each eddy
anom_bar = nan(length(sel_anom(1,1,:)),1);
N  = nan(length(sel_anom(1,1,:)),1);

for m=1:length(sel_anom(1,1,:))
	tmp = sel_anom(c-20:c+20,c-20:c+20,m);
	anom_bar(m) = pmean(tmp(:));
	N(m) = length(find(~isnan(tmp)));
	
end	



% Normalize each eddy by the mean achl in the first five time steps
% and redefine age
sel_stage=nan.*sel_k;
nanom_bar=nan.*anom_bar;

for m=1:length(uid)
	ii = find(sel_ids==uid(m));
	sel_stage(ii) = sel_k(ii)./sel_k(ii(length(ii)));	
        qq=find(sel_k(ii)==1);
	if any(qq)
		tmp = anom_bar(ii(qq));
		nanom_bar(ii) = anom_bar(ii)./pmean(tmp(:));
	else
		nanom_bar(ii)=nan;
	end
	
end	


figure(1)
clf
hold on
for m=1:length(iau)
	ii = find(sel_ids==uid(iau(m)));
	scatter(sel_k(ii),nanom_bar(ii),'.r')
end	

for m=1:length(icu)
	ii = find(sel_ids==uid(icu(m)));
	scatter(sel_k(ii),nanom_bar(ii),'.b')
end	
axis([0 60 -5 5])

figure(2)
clf
hold on
for m=1:length(iau)
	ii = find(sel_ids==uid(iau(m)));
	plot(sel_k(ii),nanom_bar(ii),'r')
end	

for m=1:length(icu)
	ii = find(sel_ids==uid(icu(m)));
	plot(sel_k(ii),nanom_bar(ii),'b')
end	
axis([0 60 -5 5])