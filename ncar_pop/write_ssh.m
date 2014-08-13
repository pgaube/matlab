load tmp_ssh

jdays=1:5:5*length(SSH(1,1,:))
lat=tlat;
lon=tlon;
for m=1:length(jdays)
    ssh=hp_ssh(:,:,m);
    save(['/glade/u/home/pgaube/mat/POP_5D_25km_',num2str(jdays(m))],'ssh','lat','lon')
end


