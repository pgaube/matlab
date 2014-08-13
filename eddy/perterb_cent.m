load /Volumes/matlab/matlab/global/global_sam_tracks_V4_16_weeks.mat

a=0;
b=2;
c=0;
d=360;

mag = a + (b-a).*rand(length(sam_y),1);
dir = c + (d-c).*rand(length(sam_y),1);
fprintf(' perturbing \n')
[u,v]=pol2cart(deg2rad(dir),mag);
sam_x = sam_x-u;
sam_y = sam_y-v;
	

save /Volumes/matlab/matlab/global/global_pert_sam_tracks_V4_16_weeks.mat