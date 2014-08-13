clear all

spath='/Volumes/ys-home/mat/POP_BEC_JAN_15_2014_';
% spath='/glade/u/home/pgaube/mat/POP_BEC_JAN_15_2014_';

pdays=[1:5:386];


% now load pop SSH and CHLdata
load /Volumes/ys-home/mat/buff_mask_0_pt_25_degree 
% load /glade/u/home/pgaube/mat/buff_mask_0_pt_25_degree 

SSH=nan(length(tlat(:,1)),length(tlon(1,:)),length(pdays));
CHL=SSH;

for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'hp66_ssh','hp66_chl')
        if exist('hp66_ssh')
            m
            SSH(:,:,m)=hp66_ssh.*mask;
            CHL(:,:,m)=hp66_chl.*mask;
            clear *ssh *chl
        end
    end
end
save pop_hp66_ssh_and_hp66_chl tlat tlon jdays CHL SSH

for m=1:length(tlat(:,1))
    for n=1:length(tlon(1,:))
        [r0(m,n),dum,N(m,n),Sig(m,n)]=pcor(squeeze(CHL(m,n,:))',squeeze(SSH(m,n,:))',0);
    end
end

save pop_bec_cor_0 r0 N tlon tlat