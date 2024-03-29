clear all
rgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);

[north_pert_crlg_a,north_pert_crlg_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrhp66_crlg_pert_sample','n');
[south_pert_crlg_a,south_pert_crlg_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrhp66_crlg_pert_sample','n');
[north_sst_crl_a,north_sst_crl_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrwind_crl_sst_pert_wspd_sample','n');
[south_sst_crl_a,south_sst_crl_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrwind_crl_sst_pert_wspd_sample','n');				
[north_crl_a,north_crl_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrhp66_crl_sample','n');
[south_crl_a,south_crl_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrhp66_crl_sample','n');				
[north_crlg_a,north_crlg_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrhp66_crlg_sample','n');
[south_crlg_a,south_crlg_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrhp66_crlg_sample','n');				
%{
[north_oi_a,north_oi_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrsst_oi_sample','n');
[south_oi_a,south_oi_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrsst_oi_sample','n');				
[north_spd_21_a,north_spd_21_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrhp_wspd_21_sample','n');
[south_spd_21_a,south_spd_21_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrhp_wspd_21_sample','n');	
[north_ssh_a,north_ssh_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrssh_sample','n');
[south_ssh_a,south_ssh_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrssh_sample','n');
[north_spd_a,north_spd_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrhp_wspd_sample','n');
[south_spd_a,south_spd_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrhp_wspd_sample','n');			
[north_foi_a,north_foi_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrfiltered_sst_oi_sample','n');
[south_foi_a,south_foi_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrfiltered_sst_oi_sample','n');	
[north_trap_a,north_trap_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrtmask_sample ','n');
[south_trap_a,south_trap_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrtmask_sample ','n');	
[north_gradt_a,north_gradt_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat',...
				'nrgradt_sample','n');
[south_gradt_a,south_gradt_c]  =  ...
		pert_comps('/Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat',...
				'nrgradt_sample','n');	
%}				
			
save /Volumes/matlab/matlab/air-sea/comps/pert_norm_comps_16_weeks south* north* r c

				
				

