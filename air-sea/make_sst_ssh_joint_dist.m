
load tracks/midlat_tracks.mat

ii=find(amp>=20 & amp<=24);
[big_sst_a,big_sst_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'bp26_sst',...
							'/matlab/data/ReynoldsSST/mat/OI_25_30_','n');

ii=find(amp>=8 & amp<=12);
[med_sst_a,med_sst_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'bp26_sst',...
							'/matlab/data/ReynoldsSST/mat/OI_25_30_','n');

ii=find(amp>=1 & amp<=5);
[small_sst_a,small_sst_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'bp26_sst',...
							'/matlab/data/ReynoldsSST/mat/OI_25_30_','n');
							
                        
% ii=find(amp>=3 & amp<=7);
% [median_sst_a,median_sst_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),'bp26_sst',...
% 							'~/data/ReynoldsSST/mat/OI_25_30_','n');
							
save -append sst_ssh_joint_comps big* med* small*							
% %
load sst_ssh_joint_comps
zgrid_grid
dist=sqrt(xi.^2+yi.^2);
ii=find(dist<=1);
big_a_mean=pmean(big_sst_a.mean(ii))
big_c_mean=pmean(big_sst_c.mean(ii))
med_a_mean=pmean(med_sst_a.mean(ii))
med_c_mean=pmean(med_sst_c.mean(ii))
small_a_mean=pmean(small_sst_a.mean(ii))
small_c_mean=pmean(small_sst_c.mean(ii))
median_a_mean=pmean(median_sst_a.mean(ii))
median_c_mean=pmean(median_sst_c.mean(ii))

tmpa=big_sst_a.mean(ii);
tmpc=big_sst_c.mean(ii);
big_max=(max(tmpa(:))+max(abs(tmpc(:))))
tmpa=med_sst_a.mean(ii);
tmpc=med_sst_c.mean(ii);
med_max=(max(tmpa(:))+max(abs(tmpc(:))))
tmpa=small_sst_a.mean(ii);
tmpc=small_sst_c.mean(ii);
small_max=(max(tmpa(:))+max(abs(tmpc(:))))

tmpa=median_sst_a.mean(ii);
tmpc=median_sst_c.mean(ii);
median_max=(max(tmpa(:))+max(abs(tmpc(:))))							