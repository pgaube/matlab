clear all

load crl_crlg_space_slope beta S S_crit

mask=nan*S;
ii=find(S>S_crit);
mask(ii)=1;
tmp=beta(:,:,2);


cplot_comps(tmp.*mask,-.8,.8, ...
	'~/Documents/OSU/figures/crl/crl_crlg_slope_comp')

