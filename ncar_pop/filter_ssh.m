load tmp_ssh

%get rid of nans in tlat, tlon SSH
tlat(end-3:end,:)=[];
tlon(end-3:end,:)=[];
SSH(end-3:end,:,:)=[];

tlat(1:2,:)=[];
tlon(1:2,:)=[];
SSH(1:2,:,:)=[];

save -append tmp_ssh SSH tlat tlon
return

hp_ssh=nan*SSH;

for m=1:length(SSH(1,1,:))
    ssh=SSH(:,:,m);
    
    tic
    sm=smooth2d_loess(ssh,tlon(1,:),tlat(:,1),2,2,tlon(1,:),tlat(:,1));
    lp=smooth2d_loess(ssh,tlon(1,:),tlat(:,1),20,10,tlon(1,:),tlat(:,1));
    toc

    hp_ssh(:,:,m)=sm-lp;
end

save -append tmp_ssh hp_ssh tlat tlon

