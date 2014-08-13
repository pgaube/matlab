clear all
dir_list=dir(['/glade/u/home/pgaube/mat/POP_BEC_JAN_15_2014_*']);


fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(2),'name')];
load(fname,'ssh')
% mask=ones(size(ssh));
% mask(isnan(ssh))=nan;
% mask=buffnan_rad(mask,10);
% save /Volumes/ys-home/mat/buff_mask_0_pt_25_degree mask tlon tlat

load /glade/u/home/pgaube/mat/buff_mask_0_pt_25_degree mask

for m=1:length(dir_list)
    fname=['/glade/u/home/pgaube/mat/',getfield(dir_list(m),'name')];
    load(fname,'tlon','tlat','chl','ssh','jdays')
    m
%    
%     tic
%     lp=smooth2d_loess(ssh,tlon(1,:),tlat(:,1),6,6,tlon(1,:),tlat(:,1));
%     hp66_ssh=ssh-lp;
%     toc
    
    tic
    lp=real(smooth2d_loess(log10(chl.*mask),tlon(1,:),tlat(:,1),6,6,tlon(1,:),tlat(:,1)));
    hp66_chl=(chl.*mask)-10.^lp;
    toc
%     
%     figure(2)
%     clf
%     pmap(tlon,tlat,hp66_chl)
%     caxis([-.1 .1])
%     title(fname)
%     eval(['print -dpng -r300 ~/matlab/ncar_pop/figs/hp66_chl_',num2str(m)])
%     
    save(fname,'-append','hp*')
    clear lp hp* sm
    
end
