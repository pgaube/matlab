dir_list=dir(['/glade/u/home/pgaube/mat/POP_5D_25km_*'])
jdays=1:5:5*length(dir_list);
    fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(1),'name')];

for m=1:length(dir_list)
    fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(m),'name')];
    load(fname,'tlon','tlat','hp66_chl','hp21_ssh')

    
    
end
cd /glade/u/home/pgaube/matlab/pop