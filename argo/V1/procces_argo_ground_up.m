cd /data/argo
%read_profile_index_txt
cd /matlab/matlab/argo
sel_arg_prof_in_eddies
ftp_profiles
load_profiles
ftp_missing_profiles
load_profiles

return

cd /Volumes/matlab/matlab/argo
make_prof_anom
%subset_prof_region