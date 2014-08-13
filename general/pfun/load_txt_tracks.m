load read_eddy_data.091029.6wks.out
read_eddy_data(read_eddy_data>1e30)==nan;
id=read_eddy_data(:,1);
k=read_eddy_data(:,2);
track_jday=read_eddy_data(:,3);
month=read_eddy_data(:,4);
day=read_eddy_data(:,5);
year=read_eddy_data(:,6);
eid=read_eddy_data(:,7);
x=read_eddy_data(:,8);
y=read_eddy_data(:,9);
amp=read_eddy_data(:,10);
radius=read_eddy_data(:,11);
edge_ssh=read_eddy_data(:,12);
efold=read_eddy_data(:,13);
axial_speed=read_eddy_data(:,14);
prop_speed=read_eddy_data(:,15);

clear read_eddy_data
save global_tracks_V4
