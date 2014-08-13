clear all
load pop_stream_sla z_biomass*
load ~/matlab/pop/mat/pop_model_domain.mat z
clf
figure(1)
clf
hold on
plot(nanmean(z_biomass_a(1:14,:),2),z(1:14),'r');axis ij
plot(nanmean(z_biomass_c(1:14,:),2),z(1:14),'b');axis ij
daspect([.01 1 1])
box
print -dpng -r300 figs/biomass_profiles
